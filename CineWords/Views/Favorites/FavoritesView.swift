//
//  FavoritesView.swift
//  CineWords
//
//  Created by Baran on 26.06.2026.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query private var favorites: [FavoriteMovie]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cineBackground.ignoresSafeArea()
                
                if favorites.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 60))
                            .foregroundStyle(Color.cineSubtext)
                        Text("Henüz favori film yok")
                            .foregroundStyle(Color.cineSubtext)
                    }
                } else {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {
                        ForEach(favorites) { movie in
                            MovieCardView(movie: Movie(
                                id: movie.id,
                                title: movie.title,
                                overview: "",
                                posterPath: movie.posterPath,
                                voteAverage: movie.voteAverage,
                                releaseDate: movie.releaseDate
                            ))
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("❤️ Favoriler")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}
