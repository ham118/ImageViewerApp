//
//  DetailView.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import SwiftUI

struct DetailView: View {
    let photo: UnsplashPhoto
    @StateObject private var viewModel: DetailViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    init(photo: UnsplashPhoto, databaseService: DatabaseServiceProtocol? = nil, imageDownloader: ImageDownloader? = nil) {
        self.photo = photo
        //Use provided services or get from dependency injector
        let db = databaseService ?? DependencyInjector.shared.databaseService
        let downloader = imageDownloader ?? DependencyInjector.shared.imageDownloader
        
        self._viewModel = StateObject(wrappedValue: DetailViewModel(
            photo: photo,
            databaseService: db,
            imageDownloader: downloader
        ))
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    //Main image
                    AsyncImageView(url: photo.urls?.regular, contentMode: .fit, showPlaceholder: true)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .aspectRatio(calculateAspectRatio(), contentMode: .fit)
                    photographerInfoView //Photographer info
                    
                    //Description
                    if let description = photo.description, !description.isEmpty {
                        Text(description)
                            .padding()
                            .font(.body)
                    } else if let altDescription = photo.altDescription, !altDescription.isEmpty {
                        Text(altDescription)
                            .padding()
                            .font(.body)
                    }
                    statsView //Stats
                    actionButtonsView //Action buttons
                }
            }.ignoresSafeArea(.all, edges: .top)
            
            //Error alert
            if viewModel.hasError {
                VStack {
                    Spacer()
                    
                    ToastView(message: viewModel.errorMessage ?? "An error occurred", isShowing: .constant(viewModel.hasError))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                viewModel.hasError = false
                            }
                        }
                }
            }
            
            //Success toast
            if viewModel.showSuccessMessage {
                VStack {
                    Spacer()
                    ToastView(message: viewModel.successMessage, isShowing: $viewModel.showSuccessMessage)
                }
            }
            
            //Loading overlay
            if viewModel.isProcessing || viewModel.isDownloading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                LoadingView()
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(colorScheme == .dark ? Color.black : Color.white)
                    )
                    .shadow(radius: 10)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var photographerInfoView: some View {
        HStack(spacing: 12) {
            //Profile image
            AsyncImageView(url: photo.user?.profileImage?.medium, contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(photo.user?.name ?? photo.user?.username ?? "Unknown Photographer")
                    .font(.headline)
                
                if let username = photo.user?.username {
                    Text("@\(username)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    private var statsView: some View {
        HStack(spacing: 20) {
            if let likes = photo.likes {
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("\(likes)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            if viewModel.isFavorite {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("In Favorites")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    private var actionButtonsView: some View {
        VStack(spacing: 16) {
            Button {
                Task {
                    await viewModel.toggleFavorite()
                }
            } label: {
                HStack {
                    Image(systemName: viewModel.isFavorite ? "star.slash.fill" : "star.fill")
                    Text(viewModel.isFavorite ? "Remove from Favorites" : "Add to Favorites")
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.isFavorite ? Color.yellow.opacity(0.2) : Color.yellow)
                .foregroundColor(viewModel.isFavorite ? .primary : .black)
                .cornerRadius(10)
            }
            
            Button {
                Task {
                    await viewModel.downloadImage()
                }
            } label: {
                HStack {
                    Image(systemName: "arrow.down.circle.fill")
                    Text("Download Image")
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
    
    private func calculateAspectRatio() -> CGFloat {
        if let width = photo.width, let height = photo.height, width > 0, height > 0 {
            return CGFloat(width) / CGFloat(height)
        } //Calculate aspect ratio with fallback values
        return 1.0 //Default square aspect ratio if dimensions are missing
    }
}

//MARK: - Preview
#Preview {
    NavigationView {
        DetailView(
            photo: MockUnsplashAPIService().createMockPhoto(),
            databaseService: MockDatabaseService(),
            imageDownloader: ImageDownloader(apiService: MockUnsplashAPIService())
        )
    }
}
