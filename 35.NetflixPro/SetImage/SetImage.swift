//
//  SwiftUIView.swift
//  35.NetflixPro
//
//  Created by Data on 08.06.24.
//

import SwiftUI

struct SetImage: View {
    let url: URL
    @State private var image: UIImage?
    @State private var isLoading = true
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
        } else {
            if isLoading {
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            } else {
                Image(systemName: "heart")
                    .resizable()
            }
        }
    }
    
    private func loadImage() {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    image = loadedImage
                    isLoading = false
                }
            }
        }.resume()
    }
}
