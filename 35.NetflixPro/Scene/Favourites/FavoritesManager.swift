//
//  FavoritesManager.swift
//  35.NetflixPro
//
//  Created by Data on 09.06.24.
//

import SwiftUI

class FavoritesManager: ObservableObject {
    @Published var favoriteMovies: [Movie] = [] {
        didSet {
            saveFavorites()
        }
    }
    
    init() {
        loadFavorites()
    }
    
    func toggleFavorite(movie: Movie) {
        if let index = favoriteMovies.firstIndex(where: { $0.id == movie.id }) {
            favoriteMovies.remove(at: index)
        } else {
            favoriteMovies.append(movie)
        }
    }
    
    func isFavorite(movie: Movie) -> Bool {
        return favoriteMovies.contains(where: { $0.id == movie.id })
    }
    
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteMovies) {
            UserDefaults.standard.set(encoded, forKey: "favoriteMovies")
        }
    }
    
    private func loadFavorites() {
        if let savedFavorites = UserDefaults.standard.object(forKey: "favoriteMovies") as? Data {
            if let decodedFavorites = try? JSONDecoder().decode([Movie].self, from: savedFavorites) {
                favoriteMovies = decodedFavorites
            }
        }
    }
}

//var isFavorite: Bool {
//    favoriteMovies.contains { movie in
//        movie.databaseID == self.movie.databaseID
//    }
//}
