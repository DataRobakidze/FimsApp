//
//  TrailersView.swift
//  35.NetflixPro
//
//  Created by Data on 10.06.24.
//

import SwiftUI
import WebKit

struct TrailersView: View {
    let ID: String
    
    var body: some View {
        
        Video(videoID: ID)
            .frame(width: 375, height: 230)
            .cornerRadius(10)
    }
}

#Preview {
    TrailersView(ID: "")
}

struct Video: UIViewRepresentable {
    var videoID: String
    
    func makeUIView(context: Context) -> some WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}
