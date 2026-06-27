//
//  MovieService.swift
//  CineWords
//
//  Created by Baran on 25.06.2026.
//

import Foundation
import Combine

@MainActor
class MovieService: ObservableObject{
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var searchResults: [Movie] = []
    @Published var isSearching: Bool = false

    func searchMovies(query: String) async throws {
        guard !query.isEmpty else {
            searchResults = []
            return
        }
        
        isSearching = true
        defer { isSearching = false }
        
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let url = URL(string: "\(baseURL)/search/movie?api_key=\(apikey)&language=tr-TR&query=\(encodedQuery)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
        
        searchResults = response.results
    }
    
    
    private let apikey = "YOUR_TMDB_API_KEY_HERE"
    private let baseURL = "https://api.themoviedb.org/3"
    
    func fetchPopularMovies() async throws {
        isLoading = true
        defer { isLoading = false }
        
        let url = URL(string: "\(baseURL)/movie/popular?api_key=\(apikey)&language=tr-TR")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
        
        movies = response.results
    }
    
}

