//
//  AsyncImageView.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import SwiftUI

struct AsyncImageView: View {
    let url: String?
    let contentMode: ContentMode
    let showPlaceholder: Bool
    
    @State private var phase: AsyncImagePhase = .empty
    
    init(
        url: String?,
        contentMode: ContentMode = .fit,
        showPlaceholder: Bool = true
    ) {
        self.url = url
        self.contentMode = contentMode
        self.showPlaceholder = showPlaceholder
    }
    
    var body: some View {
        if let imageUrl = url, let url = URL(string: imageUrl) {
            AsyncImage(url: url) { phase in
                switch phase {
                    case .empty:
                        if showPlaceholder {
                            ShimmerView()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: contentMode)
                        //.border(.red, width: 5) //Debug purpose only
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: contentMode)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                            .foregroundColor(.gray)
                        
                }
            }
        } else {
            //Fallback for nil or invalid URL
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .foregroundColor(.gray)
        }
    }
}
