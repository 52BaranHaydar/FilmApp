//
//  MovieCardView.swift
//  CineWords
//
//  Created by Baran on 25.06.2026.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie
    
    var body: some View {
        ZStack(alignment: .bottom){
            
            posterImage
            gradientOverlay
            movieInfo
            
            
        }
        .frame(width: 120, height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    
    private var posterImage: some View {
        AsyncImage(url: movie.posterURL){
            phase in
            if let image = phase.image{
                image
                    .resizable()
                    .scaledToFill()
            } else{
                Rectangle()
                    .fill(Color.cineSurface)
                    .overlay{
                        Image(systemName: "film")
                            .font(.largeTitle)
                            .foregroundStyle(Color.cineSubtext)
                    }
            }
        }
    }
    
    private var gradientOverlay: some View{
        LinearGradient(
            colors: [.clear, .black.opacity(0.9)], startPoint: .center, endPoint: .bottom
        )
    }
    
    private var movieInfo : some View {
        VStack(alignment: .leading, spacing: 4){
            Text(movie.title)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color.cineText)
                .lineLimit(2)
            
            Text("⭐ \(String(format: "%.1f", movie.voteAverage))")
                .font(.caption2)
                .foregroundStyle(Color.cineSubtext,)
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MovieCardView(movie: Movie(
        id: 1,
        title: "Inception",
        overview: "Test açıklama",
        posterPath: nil,
        voteAverage: 8.8,
        releaseDate: "2010-07-16"
    ))
    .background(Color.cineBackground)
}
