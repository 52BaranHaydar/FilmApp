//
//  HomeView.swift
//  CineWords
//
//  Created by Baran on 26.06.2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var movieService = MovieService()
    @State private var searchText: String = ""
    
    var displayedMovies: [Movie] {
        searchText.isEmpty ? movieService.movies : movieService.searchResults
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cineBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        heroSection
                        popularSection
                        allMoviesSection
                    }
                }
                .ignoresSafeArea(edges: .top)
            }
            .navigationBarHidden(true)
            .searchable(text: $searchText, prompt: "Film ara...")
            .onChange(of: searchText) { _, newValue in
                Task {
                    try? await movieService.searchMovies(query: newValue)
                }
            }
        }
        .task {
            try? await movieService.fetchPopularMovies()
        }
    }
    
    // MARK: - Hero
    @ViewBuilder
    private var heroSection: some View {
        if searchText.isEmpty, let featured = movieService.movies.first {
            HeroBannerView(movie: featured)
        }
    }
    
    // MARK: - Popular
    @ViewBuilder
    private var popularSection: some View {
        if searchText.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                Text("🔥 Popüler Filmler")
                    .font(.headline)
                    .foregroundStyle(Color.cineText)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(movieService.movies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieCardView(movie: movie)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    // MARK: - Grid
    private var allMoviesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(searchText.isEmpty ? "🎬 Tüm Filmler" : "🔍 Sonuçlar")
                .font(.headline)
                .foregroundStyle(Color.cineText)
                .padding(.horizontal)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(displayedMovies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieCardView(movie: movie)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
