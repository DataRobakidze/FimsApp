//
//  FilmsCollection.swift
//  35.NetflixPro
//
//  Created by Data on 08.06.24.
//

import SwiftUI

struct FilmsCollection: View {
    @StateObject var viewModel = ViewModel()
    @State private var selectedMovie: Movie?
    @State private var isDetailsPresented = false
    
    let gridItems = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    func refreshData() async {
        await viewModel.fetch()
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 5) {
                    ForEach(viewModel.movies) { movie in
                        VStack {
                            if let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")") {
                                NavigationLink(destination: DetailsView(mov: movie)) {
                                    SetImage(url: posterURL)
                                        .frame(width: 100, height: 145.92)
                                        .cornerRadius(16)
                                }
                            }
                            VStack {
                                Text(movie.title)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 12))
                                    .bold()
                            }
                            Spacer()
                        }
                        .padding()
                        .listRowBackground(Color.clear)
                        .listRowSeparatorTint(.clear)
                    }
                }
                .refreshable {
                    await refreshData()
                }
                .padding()
            }
            .navigationTitle("Movies")
            .background(Color("Background"))
            .onAppear {
                Task {
                    await viewModel.fetch()
                }
            }
        }
    }
}

#Preview {
    FilmsCollection()
}
