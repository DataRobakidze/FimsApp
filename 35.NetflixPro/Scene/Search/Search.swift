//
//  Search.swift
//  35.NetflixPro
//
//  Created by Data on 08.06.24.
//

import SwiftUI
import NetworkService

struct Search: View {
    @EnvironmentObject private var viewModel: ViewModel
    @State private var searchText = ""
    @State private var filterOption: FilterOption = .name
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                VStack {
                    HStack {
                        SearchModifire(search: $searchText)
                        Menu {
                            VStack {
                                Picker(selection: $filterOption,
                                       label: EmptyView(),
                                       content: {
                                    ForEach(FilterOption.allCases, id: \.self) { option in
                                        Text(option.rawValue).tag(option)
                                    }
                                })
                                .pickerStyle(.automatic)
                                .accentColor(.white)
                            }
                        } label: {
                            Image(.more)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("FontColor"))
                        }
                        Spacer()
                    }
                    List(filteredMovies) { movie in
                        MovieRow(movie: movie)
                    }
                    .listStyle(PlainListStyle())
                }
                .navigationTitle("Search")
                
                if searchText.isEmpty {
                    VStack {
                        Text("Use the magic search!")
                            .padding()
                        Text("I will do my best to search everything \nrelevant, I promise!")
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                    }
                }
                if filteredMovies.isEmpty && !searchText.isEmpty {
                    VStack {
                        Text("Oh no, isn't this so \nembarrassing?")
                            .padding()
                            .multilineTextAlignment(.center)
                        Text("No results found. Try searching something else!")
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetch()
        }
    }
    
    private var filteredMovies: [Movie] {
            guard !searchText.isEmpty else { return [] }
            switch filterOption {
            case .name:
                return viewModel.movies.filter { $0.title.lowercased().hasPrefix(searchText.lowercased()) }
            case .genre:
                return viewModel.movies.filter { movie in
                    movie.genres?.contains { $0.name.lowercased().hasPrefix(searchText.lowercased()) } ?? false
                }
            case .year:
                return viewModel.movies.filter { $0.releaseDate.lowercased().hasPrefix(searchText.lowercased()) }
            }
        }
}

enum FilterOption: String, CaseIterable {
    case name = "Name"
    case genre = "Genre"
    case year = "Year"
}

#Preview {
    Search()
}
