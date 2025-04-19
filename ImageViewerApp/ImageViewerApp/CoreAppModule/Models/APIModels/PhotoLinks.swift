//
//  PhotoLinks.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation

struct PhotoLinks: Codable {
    let _self: String?
    let html: String?
    let download: String?
    let downloadLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case _self, html, download
        case downloadLocation = "download_location"
    }
    
    init(_self: String?, html: String?, download: String?, downloadLocation: String?) {
        self._self = _self
        self.html = html
        self.download = download
        self.downloadLocation = downloadLocation
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _self = try container.decodeIfPresent(String.self, forKey: ._self)
        html = try container.decodeIfPresent(String.self, forKey: .html)
        download = try container.decodeIfPresent(String.self, forKey: .download)
        downloadLocation = try container.decodeIfPresent(String.self, forKey: .downloadLocation)
    }
}
