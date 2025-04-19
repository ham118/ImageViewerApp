//
//  ImageDownloader.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import UIKit
import Photos

enum ImageDownloaderError: Error {
    case downloadFailed
    case saveFailed
    case permissionDenied
    case invalidURL
    
    var description: String {
        switch self {
            case .downloadFailed:
                return "Failed to download the image"
            case .saveFailed:
                return "Failed to save the image to photos"
            case .permissionDenied:
                return "Permission to save photos was denied"
            case .invalidURL:
                return "Invalid image URL"
        }
    }
}

actor ImageDownloader {
    private let apiService: UnsplashAPIServiceProtocol
    
    init(apiService: UnsplashAPIServiceProtocol) {
        self.apiService = apiService
    }
    
    func downloadImage(from url: String) async throws -> UIImage {
        if url.isEmpty {
            throw ImageDownloaderError.invalidURL
        }
        
        let data = try await apiService.downloadPhoto(from: url)
        guard let image = UIImage(data: data) else {
            throw ImageDownloaderError.downloadFailed
        }
        return image
    }
    
    func saveImageToPhotos(_ image: UIImage) async throws {
        try await MainActor.run {
            let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
            if status == .notDetermined {
                return
            } else if status != .authorized {
                throw ImageDownloaderError.permissionDenied
            }
        }
        
        //Request permission if not determined
        let authorized = await PHPhotoLibrary.requestAuthorization(for: .addOnly) == .authorized
        if !authorized {
            throw ImageDownloaderError.permissionDenied
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            PHPhotoLibrary.shared().performChanges {
                PHAssetCreationRequest.forAsset().addResource(with: .photo, data: image.jpegData(compressionQuality: 0.9)!, options: nil)
            } completionHandler: { success, error in
                if success {
                    continuation.resume()
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: ImageDownloaderError.saveFailed)
                }
            }
        }
    }
}
