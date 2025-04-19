//
//  ContentView.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import SwiftUI

struct AppTabView: View {
    @Environment(\.injector) private var injector
    @State private var selectedTab = 0
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(apiService: injector.apiService)
                .tabItem {
                    Label("Home", systemImage: "photo.on.rectangle")
                }
                .tag(0)
            
            FavoritesView(databaseService: injector.databaseService)
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
                .tag(1)
            
            SettingsView(isDarkMode: $isDarkMode)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
    }
}

// MARK: - Preview
#Preview {
    AppTabView().withInjector(DependencyInjector.preview)
}
