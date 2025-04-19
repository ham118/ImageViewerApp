//
//  APIConfig.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation

enum APIConfig {
    static let accessKey = "4Pqu2P-EV8PzO97rNATc-SZmhvf-GX9GC4OAXWMoFJI" //Unsplash API key
    static let baseURL = "https://api.unsplash.com"
    
    enum Endpoints {
        static let photos = "/photos"
        static let search = "/search/photos"
    }
    
    enum Parameters {
        static let clientId = "client_id"
        static let page = "page"
        static let perPage = "per_page"
        static let query = "query"
        static let orderBy = "order_by"
    }
    
    enum Values {
        static let perPageDefault = "10"
        static let orderByLatest = "latest"
    }
}
