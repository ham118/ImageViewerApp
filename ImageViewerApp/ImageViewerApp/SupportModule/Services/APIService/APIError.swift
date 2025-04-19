//
//  APIError.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
    case serverError(Int)
    case unknown
    
    var description: String {
        switch self {
            case .invalidURL:
                return "Invalid URL"
            case .invalidResponse:
                return "Invalid response from server"
            case .requestFailed(let error):
                return "Request failed: \(error.localizedDescription)"
            case .decodingFailed(let error):
                return "Failed to decode response: \(error.localizedDescription)"
            case .serverError(let statusCode):
                return "Server error with status code: \(statusCode)"
            case .unknown:
                return "Unknown error occurred"
        }
    }
}
