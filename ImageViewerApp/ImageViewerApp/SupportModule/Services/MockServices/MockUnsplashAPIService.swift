//
//  MockUnsplashAPIService.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation

//Mock API Service for testing and previews
class MockUnsplashAPIService: UnsplashAPIServiceProtocol {
    func fetchPhotos(page: Int) async throws -> [UnsplashPhoto] {
        return [createMockPhoto(), createMockPhoto(id: "2")]
    }
    
    func searchPhotos(query: String, page: Int) async throws -> SearchResponse {
        return SearchResponse(
            total: 10,
            totalPages: 1,
            results: [createMockPhoto(), createMockPhoto(id: "2")]
        )
    }
    
    func downloadPhoto(from url: String) async throws -> Data {
        return Data() //Placeholder data
    }
    
    func createMockPhoto(id: String = "1") -> UnsplashPhoto {
        return UnsplashPhoto(
            id: id,
            createdAt: "2023-01-01T12:00:00Z",
            updatedAt: "2023-01-01T12:00:00Z",
            width: 4000,
            height: 3000,
            color: "#E5E5E5",
            blurHash: "LFC$yHwc8^$yIAS$%M%00KxukYIp",
            description: "A beautiful landscape",
            altDescription: "Mountain view with sunset",
            urls: PhotoURLs(
                raw: "https://example.com/photo.jpg",
                full: "https://example.com/photo.jpg",
                regular: "https://example.com/photo.jpg",
                small: "https://example.com/photo.jpg",
                thumb: "https://example.com/photo.jpg",
                smallS3: "https://example.com/photo.jpg"
            ),
            links: PhotoLinks(
                _self: "https://api.unsplash.com/photos/\(id)",
                html: "https://unsplash.com/photos/\(id)",
                download: "https://unsplash.com/photos/\(id)/download",
                downloadLocation: "https://api.unsplash.com/photos/\(id)/download"
            ),
            likes: 42,
            likedByUser: false,
            user: UnsplashUser(
                id: "user\(id)",
                updatedAt: "2023-01-01T12:00:00Z",
                username: "photographer\(id)",
                name: "Awesome Photographer \(id)",
                firstName: "Awesome",
                lastName: "Photographer",
                twitterUsername: "photographer",
                portfolioUrl: "https://example.com",
                bio: "I take photos",
                location: "Earth",
                links: UserLinks(
                    _self: "https://api.unsplash.com/users/photographer\(id)",
                    html: "https://unsplash.com/@photographer\(id)",
                    photos: "https://api.unsplash.com/users/photographer\(id)/photos",
                    likes: "https://api.unsplash.com/users/photographer\(id)/likes",
                    portfolio: "https://api.unsplash.com/users/photographer\(id)/portfolio",
                    following: "https://api.unsplash.com/users/photographer\(id)/following",
                    followers: "https://api.unsplash.com/users/photographer\(id)/followers"
                ),
                profileImage: ProfileImage(
                    small: "https://example.com/profile.jpg",
                    medium: "https://example.com/profile.jpg",
                    large: "https://example.com/profile.jpg"
                ),
                instagramUsername: "photographer",
                totalCollections: 10,
                totalLikes: 100,
                totalPhotos: 50,
                acceptedTos: true,
                forHire: true,
                social: UserSocial(
                    instagramUsername: "photographer",
                    portfolioUrl: "https://example.com",
                    twitterUsername: "photographer",
                    paypalEmail: nil
                )
            ),
            sponsorship: nil,
        )
    }
}
