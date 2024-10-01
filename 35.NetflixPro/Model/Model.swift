//
//  Model.swift
//  35.NetflixPro
//
//  Created by Data on 08.06.24.
//

import Foundation

struct Movie: Codable, Identifiable {
    var id: Int
    var title: String
    var overview: String
    var releaseDate: String
    var originalLanguage: String
    var posterPath: String?
    var backdropPath: String?
    var voteAverage: Double
    var runtime: Int?
    var genres: [Genre]?
    var trailerKey: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case runtime
        case genres
        case trailerKey = "key"
    }
}


struct MovieResult: Decodable {
    let results: [Movie]
}

struct MovieDetail: Decodable {
    let runtime: Int
    let genres: [Genre]
}

struct Genre: Codable, Identifiable {
    var id: Int
    var name: String
}

struct MovieTrailers: Decodable {
    struct Trailer: Decodable {
        let key: String
    }
    let results: [Trailer]
}
