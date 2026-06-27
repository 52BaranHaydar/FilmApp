//
//  HeroBannerView.swift
//  CineWords
//
//  Created by Baran on 25.06.2026.
//

import SwiftUI

struct HeroBannerView: View {
    let movie: Movie
    
    var body: some View {
        ZStack(alignment: .bottom) {
            bannerImage
            gradientOverlay
            movieDetails
        }
    }
    
    private var bannerImage: some View {
        AsyncImage(url: movie.posterURL) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.cineSurface)
            }
        }
        .frame(height: 500)
        .clipped()
    }
    
    private var gradientOverlay: some View {
        LinearGradient(
            colors: [.clear, Color.cineBackground],
            startPoint: .center,
            endPoint: .bottom
        )
    }
    
    private var actionButtons: some View {
        HStack(spacing: 12) {
            Button {
            } label: {
                Label("İzle", systemImage: "play.fill")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(Color.cineText)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Button {
            } label: {
                Label("Listeye Ekle", systemImage: "plus")
                    .font(.headline)
                    .foregroundStyle(Color.cineText)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.cineSurface)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
    
    private var movieDetails: some View{
        VStack(alignment: .leading, spacing: 12) {
            Text(movie.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.cineText)
            
            Text(movie.overview)
                .font(.caption)
                .foregroundStyle(Color.cineSubtext)
                .lineLimit(3)
            
            actionButtons
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HeroBannerView(movie: Movie(
        id: 1,
        title: "Inception",
        overview: "Bir hırsız, insanların rüyalarına girerek bilinçaltlarından sır çalma konusunda eşsiz bir yeteneğe sahiptir.",
        posterPath: nil,
        voteAverage: 8.8,
        releaseDate: "2010-07-16"
    ))
    .background(Color.cineBackground)
}
