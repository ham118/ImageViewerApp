//
//  ShimmerView.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import SwiftUI

struct ShimmerView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
            
            Color.white
                .mask(
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.clear, Color.white.opacity(0.5), Color.clear]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .offset(x: isAnimating ? 400 : -400)
                )
                .blendMode(.screen)
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                isAnimating = true
            }
        }
    }
}
