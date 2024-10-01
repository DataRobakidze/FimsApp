//
//  ViewModel.swift
//  35.NetflixPro
//
//  Created by Data on 08.06.24.
//

import Foundation
import Combine
import NetworkService

class ViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var movies: [Movie] = []
    @Published var currentPage: Int = 1
    private let itemsPerPage = 20
    private let maxPagesToFetch = 30
    @Published var searchTerm: String = ""
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetch() {
        guard !isLoading && currentPage <= maxPagesToFetch else { return }
        isLoading = true
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=c7ace6bdb313416da5e4820264823aa0&page=\(currentPage)"
        
        NetworkService().getData(urlString: urlString) { [weak self] (result: Result<MovieResult, Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let movieResult):
                    self.movies.append(contentsOf: movieResult.results)
                    self.currentPage += 1
                    
                    for movie in movieResult.results {
                        self.fetchMovieDetail(movieId: movie.id)
                    }
                    
                    for movie in movieResult.results {
                        self.fetchMovieTrailers(movieId: movie.id)
                    }
                    
                    if self.movies.count % self.itemsPerPage == 0 && self.currentPage <= self.maxPagesToFetch {
                        self.fetch()
                    }
                case .failure(let error):
                    print("Fetch failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchMovieDetail(movieId: Int) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=c7ace6bdb313416da5e4820264823aa0"
        
        NetworkService().getData(urlString: urlString) { [weak self] (result: Result<MovieDetail, Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let movieDetail):
                    if let index = self.movies.firstIndex(where: { $0.id == movieId }) {
                        self.movies[index].runtime = movieDetail.runtime
                        self.movies[index].genres = movieDetail.genres
                    }
                case .failure(let error):
                    print("Fetch failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchMovieTrailers(movieId: Int) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=c7ace6bdb313416da5e4820264823aa0"
        
        NetworkService().getData(urlString: urlString) { [weak self] (result: Result<MovieTrailers, Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let movieTrailers):
                    if let trailerKey = movieTrailers.results.first?.key,
                       let index = self.movies.firstIndex(where: { $0.id == movieId }) {
                        self.movies[index].trailerKey = trailerKey
                    }
                case .failure(let error):
                    print("Fetch failed: \(error.localizedDescription)")
                }
            }
        }
    }
}

