//
//  LoadingView.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
                .padding()
            
            Text("Loading...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}




