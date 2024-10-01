//
//  DetailsView.swift
//  35.NetflixPro
//
//  Created by Data on 08.06.24.
//

import SwiftUI

struct DetailsView: View {
    let mov: Movie
    @State private var isPressed = false
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea(.all)
            ScrollView {
                VStack {
                    ZStack {
                        if let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/\(mov.backdropPath ?? "")") {
                            SetImage(url: posterURL)
                                .scaledToFill()
                                .frame(width: 375, height: 210.94)
                                .cornerRadius(16)
                        }
                        VStack {
                            Spacer()
                                .frame(height: 178)
                            HStack {
                                Spacer()
                                    .frame(width: 310)
                                ZStack {
                                    Rectangle()
                                        .fill(Color("ReviewBack"))
                                        .frame(width: 54, height: 24)
                                        .cornerRadius(8)
                                    HStack {
                                        Image("Star")
                                            .resizable()
                                            .frame(width: 16, height: 16)
                                        Text(String(format:"%.1f", mov.voteAverage))
                                            .foregroundStyle(Color("ReviewColoe"))
                                            .font(.system(size: 12))
                                            .bold()
                                    }
                                }
                            }
                        }
                    }
                    VStack {
                        HStack {
                            Spacer()
                                .frame(width: 29)
                            if let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/\(mov.posterPath ?? "")") {
                                SetImage(url: posterURL)
                                    .scaledToFill()
                                    .frame(width: 95, height: 120)
                                    .cornerRadius(16)
                            }
                            VStack {
                                Spacer()
                                Text(mov.title)
                                    .font(.system(size: 18))
                                    .bold()
                            }
                            Spacer()
                        }
                        .padding(.top, -70)
                    }
                    Spacer()
                        .frame(height: 16)
                    HStack {
                        HStack {
                            Image("Calendar")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color("FontColor"))
                            Text(String(mov.releaseDate.prefix(4)))
                                .font(.system(size: 12))
                        }
                        Rectangle()
                            .frame(width: 1, height: 16)
                            .foregroundColor(.gray)
                        HStack {
                            Image("Time")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color("FontColor"))
                            Text("\(mov.runtime ?? 0) minutes")
                                .font(.system(size: 12))
                        }
                        Rectangle()
                            .frame(width: 1, height: 16)
                            .foregroundColor(.gray)
                        if let genres = mov.genres {
                            HStack {
                                Image("Action")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(Color("FontColor"))
                                Text(genres.map { $0.name }.joined(separator: ", "))
                                    .font(.system(size: 12))
                            }
                        }
                    }
                    HStack {
                        Spacer()
                            .frame(width: 24)
                        Text("About Movie")
                            .font(.system(size: 14))
                            .bold()
                        Spacer()
                        Button {
                            favoritesManager.toggleFavorite(movie: mov)
                            isPressed = favoritesManager.isFavorite(movie: mov)
                        } label: {
                            Image(isPressed ? "FillHeart" : "Heart")
                                .resizable()
                                .frame(width: 21, height: 20)
                                .foregroundStyle(Color("FontColor"))
                        }
                        Spacer()
                            .frame(width: 24)
                    }
                    .padding(.top)
                    
                    Rectangle()
                        .foregroundColor(Color("LineColor"))
                        .frame(width: 340, height: 4)
                    VStack {
                        HStack {
                            Spacer()
                                .frame(width: 10)
                            Text(mov.overview)
                                .padding()
                                .font(.system(size: 12))
                            Spacer()
                                .frame(width: 10)
                        }
                    }
                    VStack {
                        
                        Text("Trailer")
                            .font(.title)
                            .fontWeight(.bold)
                        if let trailerID = mov.trailerKey {
                            TrailersView(ID: trailerID)
                        }
                    }
                }
                .navigationTitle(mov.title)
            }
        }
        .onAppear {
            isPressed = favoritesManager.isFavorite(movie: mov)
        }
    }
}

