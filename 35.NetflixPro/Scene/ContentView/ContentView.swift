//
//  ContentView.swift
//  35.NetflixPro
//
//  Created by Data on 08.06.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FilmsCollection()
                .tabItem {
                    Label("Films", image: "Home")
                }
            Search()
                .tabItem {
                    Label("Search", image: "Search")
                }
            Favourites()
                .tabItem {
                    Label("Favourites", image: "Favourites")
                }
                .badge("1")
        }
        .background(Color("TabViewBack").edgesIgnoringSafeArea(.all))
        .accentColor(Color("accentColor"))
    }
}

#Preview {
    ContentView()
}
