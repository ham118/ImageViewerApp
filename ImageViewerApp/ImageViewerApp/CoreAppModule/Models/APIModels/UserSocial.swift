//
//  UserSocial.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation

struct UserSocial: Codable {
    let instagramUsername: String?
    let portfolioUrl: String?
    let twitterUsername: String?
    let paypalEmail: String?
    
    enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username"
        case portfolioUrl = "portfolio_url"
        case twitterUsername = "twitter_username"
        case paypalEmail = "paypal_email"
    }
    
    init(instagramUsername: String?, portfolioUrl: String?, twitterUsername: String?, paypalEmail: String?) {
        self.instagramUsername = instagramUsername
        self.portfolioUrl = portfolioUrl
        self.twitterUsername = twitterUsername
        self.paypalEmail = paypalEmail
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        instagramUsername = try container.decodeIfPresent(String.self, forKey: .instagramUsername)
        portfolioUrl = try container.decodeIfPresent(String.self, forKey: .portfolioUrl)
        twitterUsername = try container.decodeIfPresent(String.self, forKey: .twitterUsername)
        paypalEmail = try container.decodeIfPresent(String.self, forKey: .paypalEmail)
    }
}
