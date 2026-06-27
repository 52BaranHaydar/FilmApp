//
//  MovieDetailView.swift
//  CineWords
//
//  Created by Baran on 26.06.2026.
//

import SwiftUI
import SwiftData

struct MovieDetailView: View {
    let movie: Movie
    @Environment(\.modelContext) private var context
    @Query private var favorites: [FavoriteMovie]
    
    var isFavorite: Bool {
        favorites.contains { $0.id == movie.id }
    }
    
    var body: some View {
        ZStack {
            Color.cineBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    posterSection
                    infoSection
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
    
    // MARK: - Poster
    private var posterSection: some View {
        AsyncImage(url: movie.posterURL) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 450)
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.cineSurface)
                    .frame(height: 450)
            }
        }
        .overlay {
            LinearGradient(
                colors: [.clear, Color.cineBackground],
                startPoint: .center,
                endPoint: .bottom
            )
        }
    }
    
    // MARK: - Info
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            titleRow
            metaRow
            overviewText
            actionButtons
        }
        .padding()
    }
    
    private var titleRow: some View {
        Text(movie.title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(Color.cineText)
    }
    
    private var metaRow: some View {
        HStack(spacing: 16) {
            Label("\(String(format: "%.1f", movie.voteAverage))", systemImage: "star.fill")
                .foregroundStyle(.yellow)
            Text(movie.releaseDate)
                .foregroundStyle(Color.cineSubtext)
        }
        .font(.subheadline)
    }
    
    private var overviewText: some View {
        Text(movie.overview)
            .font(.body)
            .foregroundStyle(Color.cineSubtext)
            .lineSpacing(6)
    }
    
    // MARK: - Buttons
    private var actionButtons: some View {
        HStack(spacing: 12) {
            playButton
            favoriteButton
        }
    }
    
    private var playButton: some View {
        Button { } label: {
            Label("İzle", systemImage: "play.fill")
                .font(.headline)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.cineText)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    private var favoriteButton: some View {
        Button {
            toggleFavorite()
        } label: {
            Label(
                isFavorite ? "Favoride" : "Listeme Ekle",
                systemImage: isFavorite ? "heart.fill" : "plus"
            )
            .font(.headline)
            .foregroundStyle(isFavorite ? Color.cineAccent : Color.cineText)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.cineSurface)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    // MARK: - Functions
    private func toggleFavorite() {
        if isFavorite {
            if let favorite = favorites.first(where: { $0.id == movie.id }) {
                context.delete(favorite)
            }
        } else {
            context.insert(FavoriteMovie(movie: movie))
        }
    }
}

#Preview {
    MovieDetailView(movie: Movie(
        id: 1,
        title: "Inception",
        overview: "Bir hırsız, insanların rüyalarına girerek bilinçaltlarından sır çalma konusunda eşsiz bir yeteneğe sahiptir.",
        posterPath: nil,
        voteAverage: 8.8,
        releaseDate: "2010-07-16"
    ))
    .modelContainer(for: FavoriteMovie.self, inMemory: true)
}
