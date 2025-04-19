//
//  ProfileImage.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation

struct ProfileImage: Codable {
    let small: String?
    let medium: String?
    let large: String?
    
    enum CodingKeys: String, CodingKey {
        case small, medium, large
    }
    
    init(small: String?, medium: String?, large: String?) {
        self.small = small
        self.medium = medium
        self.large = large
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        small = try container.decodeIfPresent(String.self, forKey: .small)
        medium = try container.decodeIfPresent(String.self, forKey: .medium)
        large = try container.decodeIfPresent(String.self, forKey: .large)
    }
}
