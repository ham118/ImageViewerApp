//
//  SettingsView.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Binding var isDarkMode: Bool
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    Button("Visit Unsplash") {
                        if let url = URL(string: "https://unsplash.com") {
                            openURL(url)
                        }
                    }
                    
                    Button("API Documentation") {
                        if let url = URL(string: "https://unsplash.com/documentation") {
                            openURL(url)
                        }
                    }
                }
                
                Section(header: Text("Credits")) {
                    Text("Photos provided by Unsplash")
                        .font(.footnote)
                    Text("Built with Swift & SwiftUI")
                        .font(.footnote)
                    Text("Created by Harsh M")
                        .font(.footnote)
                    Button("🔗 LinkedIn Profile") {
                        if let url = URL(string: "https://www.linkedin.com/in/ham118") {
                            openURL(url)
                        }
                    }
                    Button("🐱 Github Profile") {
                        if let url = URL(string: "https://www.github.com/ham118") {
                            openURL(url)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

//MARK: - Preview
#Preview {
    SettingsView(isDarkMode: .constant(false))
}
