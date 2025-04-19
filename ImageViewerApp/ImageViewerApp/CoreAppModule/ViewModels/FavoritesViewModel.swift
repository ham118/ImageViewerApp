//
//  FavoritesViewModel.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import Combine

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favoritePhotos: [UnsplashPhoto] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var hasError = false
    
    private let databaseService: DatabaseServiceProtocol
    
    init(databaseService: DatabaseServiceProtocol) {
        self.databaseService = databaseService
    }
    
    func loadFavorites() async {
        isLoading = true
        hasError = false
        errorMessage = nil
        
        let favorites = await databaseService.getFavoritePhotos()
        self.favoritePhotos = favorites.map {$0.toUnsplashPhoto()}
        self.isLoading = false
    }
    
    func removeFavorite(photoId: String?) async {
        guard let id = photoId else { return }
        do {
            try await databaseService.removePhoto(withId: id)
            // Update the list after removal
            if let index = favoritePhotos.firstIndex(where: { $0.id == id }) {
                favoritePhotos.remove(at: index)
            }
        } catch {
            self.hasError = true
            self.errorMessage = "Failed to remove from favorites: \(error.localizedDescription)"
        }
    }
}
