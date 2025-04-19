//
//  Sponsorship.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation

struct Sponsorship: Codable {
    let impressionUrls: [String]?
    let tagline: String?
    let taglineUrl: String?
    let sponsor: UnsplashUser?
    
    enum CodingKeys: String, CodingKey {
        case impressionUrls = "impression_urls"
        case tagline
        case taglineUrl = "tagline_url"
        case sponsor
    }
    
    init(impressionUrls: [String]?, tagline: String?, taglineUrl: String?, sponsor: UnsplashUser?) {
        self.impressionUrls = impressionUrls
        self.tagline = tagline
        self.taglineUrl = taglineUrl
        self.sponsor = sponsor
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        impressionUrls = try container.decodeIfPresent([String].self, forKey: .impressionUrls)
        tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        taglineUrl = try container.decodeIfPresent(String.self, forKey: .taglineUrl)
        sponsor = try container.decodeIfPresent(UnsplashUser.self, forKey: .sponsor)
    }
}
