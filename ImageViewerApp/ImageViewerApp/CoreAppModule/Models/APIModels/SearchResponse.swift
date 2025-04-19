//
//  SearchResponse.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation

struct SearchResponse: Codable {
    let total: Int?
    let totalPages: Int?
    let results: [UnsplashPhoto]?
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
    
    init(total: Int?, totalPages: Int?, results: [UnsplashPhoto]?) {
        self.total = total
        self.totalPages = totalPages
        self.results = results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total = try container.decodeIfPresent(Int.self, forKey: .total)
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        results = try container.decodeIfPresent([UnsplashPhoto].self, forKey: .results)
    }
}
