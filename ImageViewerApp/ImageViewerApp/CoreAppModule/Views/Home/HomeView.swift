//
//  HomeView.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @State private var selectedPhoto: UnsplashPhoto?
    @State private var isShowingDetail = false
    @Environment(\.colorScheme) private var colorScheme
    
    init(apiService: UnsplashAPIServiceProtocol) {
        self._viewModel = StateObject(wrappedValue: HomeViewModel(apiService: apiService))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                contentView
                
                if viewModel.hasError {
                    ErrorView(errorMessage: viewModel.errorMessage ?? "Something went wrong") {
                        viewModel.retryLastOperation()
                    }
                }
                
                if viewModel.photos.isEmpty && viewModel.isLoading {
                    LoadingView()
                }
            }
            .navigationTitle("Unsplash Gallery")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchQuery, prompt: "Search photos...")
            .fullScreenCover(item: $selectedPhoto) { photo in
                NavigationView {
                    DetailView(photo: photo)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    isShowingDetail = false
                                    selectedPhoto = nil
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.caption)
                                        Text("Close")
                                            .fontWeight(.semibold)
                                            .font(.caption)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.yellow.opacity(0.6))
                                    .foregroundColor(.black)
                                    .clipShape(Capsule())
                                    .shadow(radius: 1)
                                }
                            }
                        }
                }
            }
            .task {
                if viewModel.photos.isEmpty {
                    await viewModel.loadPhotos()
                }
            }
        }
    }
    
    private var contentView: some View {
        GeometryReader { geometry in
            //Grid testing purpose - multigrid
            let spacing: CGFloat = 10
            let totalSpacing = spacing * 3
            let itemWidth = (geometry.size.width - totalSpacing) / 2
            let itemHeight = itemWidth + 20
            
            //For better UI make single phot lazygrid
            /*let spacing: CGFloat = 10
             let totalSpacing = spacing * 2
             let itemWidth = geometry.size.width - totalSpacing*/
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(itemWidth)/*.flexible()*/,
                                                             spacing: spacing/*10*/), count: 2/*1*/),
                          spacing: spacing/*10*/) {
                    ForEach(
                        viewModel.photos
                            .filter { $0.id != nil}, id: \.phId) { photo in
                                PhotoGridItem(
                                    photo: photo,
                                    width: itemWidth,
                                    height: itemHeight
                                )
                                .onTapGesture {
                                    selectedPhoto = photo
                                    isShowingDetail = true
                                }
                                .onAppear {
                                    viewModel.loadMoreIfNeeded(currentItem: photo)
                                }
                            }
                    
                    if viewModel.isLoading && !viewModel.photos.isEmpty {
                        loadingIndicator
                    }
                }
                          .padding(.top, 8)
                
                if viewModel.photos.isEmpty && !viewModel.isLoading && !viewModel.hasError {
                    emptyStateView
                }
            }
            .background(colorScheme == .dark ? Color.black : Color(.systemGray6))
            .refreshable {
                //Reset and reload on pull-to-refresh
                viewModel.photos = []
                viewModel.currentPage = 1
                if viewModel.isSearching && !viewModel.searchQuery.isEmpty {
                    await viewModel.searchPhotos(query: viewModel.searchQuery)
                } else {
                    await viewModel.loadPhotos()
                }
            }
        }
    }
    
    private var loadingIndicator: some View {
        HStack {
            Spacer()
            ProgressView()
                .padding()
            Spacer()
        }
    }
    
    private var emptyStateView: some View {
        EmptyStateView(
            title: viewModel.isSearching ? "No results found" : "No photos available",
            message: viewModel.isSearching ? "Try a different search term" : "Pull down to refresh or try again later",
            iconName: "photo.on.rectangle.angled"
        )
    }
}

//MARK: - Preview
#Preview {
    HomeView(apiService: MockUnsplashAPIService())
}


