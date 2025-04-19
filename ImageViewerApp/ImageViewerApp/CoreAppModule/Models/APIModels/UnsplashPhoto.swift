//
//  UnsplashPhoto.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation

struct UnsplashPhoto: Identifiable, Codable, Equatable {
    let phId = UUID()
    let id: String?
    let createdAt: String?
    let updatedAt: String?
    let width: Int?
    let height: Int?
    let color: String?
    let blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: PhotoURLs?
    let links: PhotoLinks?
    let likes: Int?
    let likedByUser: Bool?
    let user: UnsplashUser?
    let sponsorship: Sponsorship?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width
        case height
        case color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case urls
        case links
        case likes
        case likedByUser = "liked_by_user"
        case user
        case sponsorship
    }
    
    init(
        id: String?,
        createdAt: String?,
        updatedAt: String?,
        width: Int?,
        height: Int?,
        color: String?,
        blurHash: String?,
        description: String?,
        altDescription: String?,
        urls: PhotoURLs?,
        links: PhotoLinks?,
        likes: Int?,
        likedByUser: Bool?,
        user: UnsplashUser?,
        sponsorship: Sponsorship?,
    ) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.width = width
        self.height = height
        self.color = color
        self.blurHash = blurHash
        self.description = description
        self.altDescription = altDescription
        self.urls = urls
        self.links = links
        self.likes = likes
        self.likedByUser = likedByUser
        self.user = user
        self.sponsorship = sponsorship
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        width = try container.decodeIfPresent(Int.self, forKey: .width)
        height = try container.decodeIfPresent(Int.self, forKey: .height)
        color = try container.decodeIfPresent(String.self, forKey: .color)
        blurHash = try container.decodeIfPresent(String.self, forKey: .blurHash)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        altDescription = try container.decodeIfPresent(String.self, forKey: .altDescription)
        urls = try container.decodeIfPresent(PhotoURLs.self, forKey: .urls)
        links = try container.decodeIfPresent(PhotoLinks.self, forKey: .links)
        likes = try container.decodeIfPresent(Int.self, forKey: .likes)
        likedByUser = try container.decodeIfPresent(Bool.self, forKey: .likedByUser)
        user = try container.decodeIfPresent(UnsplashUser.self, forKey: .user)
        sponsorship = try container.decodeIfPresent(Sponsorship.self, forKey: .sponsorship)
    }
    
    static func == (lhs: UnsplashPhoto, rhs: UnsplashPhoto) -> Bool {
        return lhs.id == rhs.id
    }
}
