//
//  ImageViewersApp.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import SwiftUI

@main
struct ImageViewersApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environment(\.injector, DependencyInjector.shared)
        }
    }
}
