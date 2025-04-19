//
//  UnsplashUser.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation

struct UnsplashUser: Codable, Identifiable {
    let id: String?
    let updatedAt: String?
    let username: String?
    let name: String?
    let firstName: String?
    let lastName: String?
    let twitterUsername: String?
    let portfolioUrl: String?
    let bio: String?
    let location: String?
    let links: UserLinks?
    let profileImage: ProfileImage?
    let instagramUsername: String?
    let totalCollections: Int?
    let totalLikes: Int?
    let totalPhotos: Int?
    let acceptedTos: Bool?
    let forHire: Bool?
    let social: UserSocial?
    
    enum CodingKeys: String, CodingKey {
        case id, username, name, bio, location, links
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioUrl = "portfolio_url"
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
        case social
    }
    
    init(id: String?, updatedAt: String?, username: String?, name: String?, firstName: String?, lastName: String?, twitterUsername: String?, portfolioUrl: String?, bio: String?, location: String?, links: UserLinks?, profileImage: ProfileImage?, instagramUsername: String?, totalCollections: Int?, totalLikes: Int?, totalPhotos: Int?, acceptedTos: Bool?, forHire: Bool?, social: UserSocial?) {
        self.id = id
        self.updatedAt = updatedAt
        self.username = username
        self.name = name
        self.firstName = firstName
        self.lastName = lastName
        self.twitterUsername = twitterUsername
        self.portfolioUrl = portfolioUrl
        self.bio = bio
        self.location = location
        self.links = links
        self.profileImage = profileImage
        self.instagramUsername = instagramUsername
        self.totalCollections = totalCollections
        self.totalLikes = totalLikes
        self.totalPhotos = totalPhotos
        self.acceptedTos = acceptedTos
        self.forHire = forHire
        self.social = social
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        twitterUsername = try container.decodeIfPresent(String.self, forKey: .twitterUsername)
        portfolioUrl = try container.decodeIfPresent(String.self, forKey: .portfolioUrl)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        location = try container.decodeIfPresent(String.self, forKey: .location)
        links = try container.decodeIfPresent(UserLinks.self, forKey: .links)
        profileImage = try container.decodeIfPresent(ProfileImage.self, forKey: .profileImage)
        instagramUsername = try container.decodeIfPresent(String.self, forKey: .instagramUsername)
        totalCollections = try container.decodeIfPresent(Int.self, forKey: .totalCollections)
        totalLikes = try container.decodeIfPresent(Int.self, forKey: .totalLikes)
        totalPhotos = try container.decodeIfPresent(Int.self, forKey: .totalPhotos)
        acceptedTos = try container.decodeIfPresent(Bool.self, forKey: .acceptedTos)
        forHire = try container.decodeIfPresent(Bool.self, forKey: .forHire)
        social = try container.decodeIfPresent(UserSocial.self, forKey: .social)
    }
}
