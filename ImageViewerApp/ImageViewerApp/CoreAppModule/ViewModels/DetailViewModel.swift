//
//  DetailViewModel.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import SwiftUI

@MainActor
class DetailViewModel: ObservableObject {
    private let photo: UnsplashPhoto
    private let databaseService: DatabaseServiceProtocol
    private let imageDownloader: ImageDownloader
    
    @Published var isFavorite = false
    @Published var isDownloading = false
    @Published var isProcessing = false
    @Published var errorMessage: String?
    @Published var hasError = false
    @Published var showSuccessMessage = false
    @Published var successMessage = ""
    
    init(photo: UnsplashPhoto, databaseService: DatabaseServiceProtocol, imageDownloader: ImageDownloader) {
        self.photo = photo
        self.databaseService = databaseService
        self.imageDownloader = imageDownloader
        Task {
            await checkFavoriteStatus()
        }
    }
    
    func checkFavoriteStatus() async {
        guard let photoId = photo.id else { return }
        isFavorite = await databaseService.isPhotoFavorite(id: photoId)
    }
    
    func toggleFavorite() async {
        guard let photoId = photo.id else {
            hasError = true
            errorMessage = "Invalid photo data"
            return
        }
        isProcessing = true
        hasError = false
        errorMessage = nil
        do {
            if isFavorite {
                try await databaseService.removePhoto(withId: photoId)
                isFavorite = false
                showSuccessMessage = true
                successMessage = "Removed from favorites"
            } else {
                try await databaseService.savePhoto(photo)
                isFavorite = true
                showSuccessMessage = true
                successMessage = "Added to favorites"
            }
        } catch {
            hasError = true
            errorMessage = "Failed to update favorites: \(error.localizedDescription)"
        }
        isProcessing = false
        //Auto-hide success message after delay
        if showSuccessMessage {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showSuccessMessage = false
            }
        }
    }
    
    func downloadImage() async {
        guard let downloadUrl = photo.urls?.full ?? photo.urls?.regular else {
            hasError = true
            errorMessage = "Download URL not available"
            return
        }
        isDownloading = true
        hasError = false
        errorMessage = nil
        do {
            let image = try await imageDownloader.downloadImage(from: downloadUrl)
            try await imageDownloader.saveImageToPhotos(image)
            showSuccessMessage = true
            successMessage = "Image saved to Photos"
        } catch let error as ImageDownloaderError {
            hasError = true
            errorMessage = error.description
        } catch {
            hasError = true
            errorMessage = "Failed to download: \(error.localizedDescription)"
        }
        isDownloading = false
        //Auto-hide success message after delay
        if showSuccessMessage {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.showSuccessMessage = false
            }
        }
    }
}
