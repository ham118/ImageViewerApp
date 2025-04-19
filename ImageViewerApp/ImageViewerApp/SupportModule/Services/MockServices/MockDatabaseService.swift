//
//  MockDatabaseService.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation

// Mock Database Service for testing and previews
class MockDatabaseService: DatabaseServiceProtocol {
    private var favorites: [String: FavoritePhoto] = [:]
    
    func savePhoto(_ photo: UnsplashPhoto) async throws {
        guard let photoId = photo.id else { return }
        let favoritePhoto = FavoritePhoto(from: photo)
        favorites[photoId] = favoritePhoto
    }
    
    func removePhoto(withId id: String) async throws {
        favorites.removeValue(forKey: id)
    }
    
    func isPhotoFavorite(id: String) async -> Bool {
        return favorites[id] != nil
    }
    
    func getFavoritePhotos() async -> [FavoritePhoto] {
        return Array(favorites.values)
    }
}
