//
//  UserLinks.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation

struct UserLinks: Codable {
    let _self: String?
    let html: String?
    let photos: String?
    let likes: String?
    let portfolio: String?
    let following: String?
    let followers: String?
    
    enum CodingKeys: String, CodingKey {
        case _self, html, photos, likes, portfolio, following, followers
    }
    
    init(_self: String?, html: String?, photos: String?, likes: String?, portfolio: String?, following: String?, followers: String?) {
        self._self = _self
        self.html = html
        self.photos = photos
        self.likes = likes
        self.portfolio = portfolio
        self.following = following
        self.followers = followers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _self = try container.decodeIfPresent(String.self, forKey: ._self)
        html = try container.decodeIfPresent(String.self, forKey: .html)
        photos = try container.decodeIfPresent(String.self, forKey: .photos)
        likes = try container.decodeIfPresent(String.self, forKey: .likes)
        portfolio = try container.decodeIfPresent(String.self, forKey: .portfolio)
        following = try container.decodeIfPresent(String.self, forKey: .following)
        followers = try container.decodeIfPresent(String.self, forKey: .followers)
    }
}
