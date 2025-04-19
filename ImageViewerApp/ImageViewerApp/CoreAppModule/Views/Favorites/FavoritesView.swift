//
//  FavoritesView.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel: FavoritesViewModel
    @State private var selectedPhoto: UnsplashPhoto?
    @State private var isShowingDetail = false
    @Environment(\.colorScheme) private var colorScheme
    
    init(databaseService: DatabaseServiceProtocol) {
        self._viewModel = StateObject(wrappedValue: FavoritesViewModel(databaseService: databaseService))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                contentView
                if viewModel.hasError {
                    ErrorView(errorMessage: viewModel.errorMessage ?? "Something went wrong") {
                        Task {
                            await viewModel.loadFavorites()
                        }
                    }
                }
                
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .navigationTitle("Favorites")
            .fullScreenCover(item: $selectedPhoto) { photo in
                NavigationView {
                    DetailView(photo: photo)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    isShowingDetail = false
                                    selectedPhoto = nil
                                    Task { //Reload favorites after detail view is dismissed
                                        await viewModel.loadFavorites()
                                    }
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
                await viewModel.loadFavorites()
            }
            .refreshable {
                await viewModel.loadFavorites()
            }
        }
    }
    
    private var contentView: some View {
        Group {
            if viewModel.favoritePhotos.isEmpty && !viewModel.isLoading {
                emptyStateView
            } else {
                GeometryReader { geometry in
                    let itemWidth = geometry.size.width - 60
                    List {
                        ForEach(viewModel.favoritePhotos.filter { $0.id != nil }) { photo in
                            PhotoGridItem(
                                photo: photo,
                                width: itemWidth,
                                height: itemWidth
                            )
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .cornerRadius(8)
                            .shadow(radius: 1)
                            .listRowSpacing(16)
                            .contextMenu {
                                Button(role: .destructive) {
                                    Task {
                                        await viewModel.removeFavorite(photoId: photo.id)
                                    }
                                } label: {
                                    Label("Remove from Favorites", systemImage: "trash")
                                }
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    Task {
                                        await viewModel.removeFavorite(photoId: photo.id)
                                    }
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                            .onTapGesture {
                                selectedPhoto = photo
                                isShowingDetail = true
                            }
                        }
                    }
                    .background(colorScheme == .dark ? Color.black : Color(.systemGray6))
                }
            }
        }
    }
    
    private var emptyStateView: some View {
        EmptyStateView(
            title: "No Favorites Yet",
            message: "Photos you add to favorites will appear here",
            iconName: "star"
        )
    }
}

//MARK: - Preview
#Preview {
    FavoritesView(databaseService: MockDatabaseService())
}
