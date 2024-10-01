//
//  MovieRowView.swift
//  35.NetflixPro
//
//  Created by Data on 08.06.24.
//

import SwiftUI

struct MovieRow: View {
    
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let posterPath = movie.posterPath,
                   let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") {
                    NavigationLink(destination: DetailsView(mov: movie)) {
                        SetImage(url: posterURL)
                            .scaledToFill()
                            .frame(width: 95, height: 120)
                            .cornerRadius(16)
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .lineLimit(1)
                                .font(.system(size: 16))
                            Spacer()
                                .frame(height: 10)
                            HStack {
                                Image("Star")
                                    .resizable()
                                    .frame(width: 16,height: 16)
                                Text(String(format:"%.1f",movie.voteAverage))
                                    .foregroundStyle(Color("ReviewColoe"))
                                    .font(.system(size: 12))
                                    .bold()
                            }
                            
                            if let genres = movie.genres {
                                HStack {
                                    Image("Action")
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(Color("FontColor"))
                                    Text(genres.map { $0.name }.joined(separator: ", "))
                                        .font(.system(size: 12))
                                }
                            }
                            HStack {
                                Image("Calendar")
                                    .resizable()
                                    .frame(width: 16,height: 16)
                                    .foregroundColor(Color("FontColor"))
                                Text(String(movie.releaseDate.prefix(4)))
                                    .font(.system(size: 12))
                            }
                            HStack {
                                Image("Time")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(Color("FontColor"))
                                
                                Text("\(movie.runtime ?? 0) minutes")
                                    .font(.system(size: 12))
                                
                            }
                        }
                    }
                }
                
            }
            
        }
        .padding()
        .listRowBackground(Color.clear)
        .listRowSeparatorTint(.clear)
    }
}
