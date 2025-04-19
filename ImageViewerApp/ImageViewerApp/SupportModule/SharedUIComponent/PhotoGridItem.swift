//
//  PhotoGridItem.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import SwiftUI

struct PhotoGridItem: View {
    let photo: UnsplashPhoto
    let width: CGFloat, height: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImageView(url: photo.urls?.regular)
                .cornerRadius(8)
            
            //Photographer name overlay
            HStack {
                Text(photo.user?.name ?? photo.user?.username ?? "Unknown Photographer")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(1)
                Spacer()
            }
            .frame(minHeight: 26)
            .padding(12)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.black.opacity(0.8), .clear]),
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
        }
        .frame(width: self.width, height: self.height)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

//#Preview {
//    PhotoGridItem(photo: MockUnsplashAPIService().createMockPhoto())
//}
