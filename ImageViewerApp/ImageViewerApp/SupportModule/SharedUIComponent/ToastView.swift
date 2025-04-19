//
//  ToastView.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import SwiftUI

struct ToastView: View {
    let message: String
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            Spacer()
            if isShowing {
                HStack {
                    Text(message)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    Button {
                        withAnimation {
                            isShowing = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .background(Color.black.opacity(0.8))
                .cornerRadius(10)
                .padding()
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: isShowing)
            }
        }
    }
}
