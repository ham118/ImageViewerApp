//
//  PhotoURLs.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation

struct PhotoURLs: Codable {
    let raw: String?
    let full: String?
    let regular: String?
    let small: String?
    let thumb: String?
    let smallS3: String?
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
    
    init(raw: String?, full: String?, regular: String?, small: String?, thumb: String?, smallS3: String?) {
        self.raw = raw
        self.full = full
        self.regular = regular
        self.small = small
        self.thumb = thumb
        self.smallS3 = smallS3
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        raw = try container.decodeIfPresent(String.self, forKey: .raw)
        full = try container.decodeIfPresent(String.self, forKey: .full)
        regular = try container.decodeIfPresent(String.self, forKey: .regular)
        small = try container.decodeIfPresent(String.self, forKey: .small)
        thumb = try container.decodeIfPresent(String.self, forKey: .thumb)
        smallS3 = try container.decodeIfPresent(String.self, forKey: .smallS3)
    }
}
