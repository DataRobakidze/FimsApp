//
//  Favourites.swift
//  35.NetflixPro
//
//  Created by Data on 09.06.24.
//

import SwiftUI

struct Favourites: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                VStack {
                    if favoritesManager.favoriteMovies.isEmpty {
                        Text("No favourites yet")
                            .padding()
                        Text("All moves marked as favourite will be\n added here")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    } else {
                        List {
                            ForEach(favoritesManager.favoriteMovies) { movie in
                                MovieRow(movie: movie)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                .navigationTitle("Favourites")
            }
        }
    }
}

#Preview {
    Favourites()
}
