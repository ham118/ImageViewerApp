//
//  UnsplashAPIService.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//
import Foundation

protocol UnsplashAPIServiceProtocol {
    func fetchPhotos(page: Int) async throws -> [UnsplashPhoto]
    func searchPhotos(query: String, page: Int) async throws -> SearchResponse
    func downloadPhoto(from url: String) async throws -> Data
}

actor UnsplashAPIService: UnsplashAPIServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchPhotos(page: Int = 1) async throws -> [UnsplashPhoto] {
        var components = URLComponents(string: APIConfig.baseURL + APIConfig.Endpoints.photos)
        components?.queryItems = [
            URLQueryItem(name: APIConfig.Parameters.clientId, value: APIConfig.accessKey),
            URLQueryItem(name: APIConfig.Parameters.page, value: String(page)),
            URLQueryItem(name: APIConfig.Parameters.perPage, value: APIConfig.Values.perPageDefault),
            URLQueryItem(name: APIConfig.Parameters.orderBy, value: APIConfig.Values.orderByLatest)
        ]
        
        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        
        return try await performRequest(url: url)
    }
    
    func searchPhotos(query: String, page: Int = 1) async throws -> SearchResponse {
        var components = URLComponents(string: APIConfig.baseURL + APIConfig.Endpoints.search)
        components?.queryItems = [
            URLQueryItem(name: APIConfig.Parameters.clientId, value: APIConfig.accessKey),
            URLQueryItem(name: APIConfig.Parameters.query, value: query),
            URLQueryItem(name: APIConfig.Parameters.page, value: String(page)),
            URLQueryItem(name: APIConfig.Parameters.perPage, value: APIConfig.Values.perPageDefault)
        ]
        
        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        
        return try await performRequest(url: url)
    }
    
    func downloadPhoto(from url: String) async throws -> Data {
        guard let downloadURL = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await session.data(from: downloadURL)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(httpResponse.statusCode)
        }
        
        return data
    }
    
    private func performRequest<T: Decodable>(url: URL) async throws -> T {
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError(httpResponse.statusCode)
            }
            
            // For debugging purposes, print the JSON response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("API: \(url)")
                print("JSON Response: \(jsonString.prefix(500))...") // Print first 500 chars
            }
            
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            } catch {
                print("Decoding error: \(error)")
                throw APIError.decodingFailed(error)
            }
        } catch let error as APIError { throw error
        } catch { throw APIError.requestFailed(error) }
    }
}
