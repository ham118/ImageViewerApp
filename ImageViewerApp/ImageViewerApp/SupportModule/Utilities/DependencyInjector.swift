//
//  DependencyInjector.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import SwiftUI

//Dependency injection container
@MainActor
class DependencyInjector {
    static let shared = DependencyInjector()
    
    private init() {}
    
    lazy var apiService: UnsplashAPIServiceProtocol = UnsplashAPIService()
    lazy var databaseService: DatabaseServiceProtocol = {
        do {
            return try DatabaseService()
        } catch {
            print("Failed to initialize DatabaseService: \(error)")
            return MockDatabaseService()
        }
    }()
    
    lazy var imageDownloader: ImageDownloader = ImageDownloader(apiService: apiService)
    
    //For preview and testing
    static var preview: DependencyInjector {
        let injector = DependencyInjector()
        injector.apiService = MockUnsplashAPIService()
        injector.databaseService = MockDatabaseService()
        return injector
    }
}

//Property wrapper for easy DI
@MainActor
struct InjectedObject<T> {
    let wrappedValue: T
    init(_ keyPath: KeyPath<DependencyInjector, T>) {
        self.wrappedValue = DependencyInjector.shared[keyPath: keyPath]
    }
}

//Extension for SwiftUI environment values
@MainActor
private struct InjectorKey: @preconcurrency EnvironmentKey {
    static var defaultValue = DependencyInjector.shared
}

extension EnvironmentValues {
    var injector: DependencyInjector {
        get { self[InjectorKey.self] }
        set { self[InjectorKey.self] = newValue }
    }
}

extension View {
    func withInjector(_ injector: DependencyInjector) -> some View {
        environment(\.injector, injector)
    }
}
