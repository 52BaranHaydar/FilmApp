//
//  FavoriteMovie.swift
//  CineWords
//
//  Created by Baran on 26.06.2026.
//

import Foundation
import SwiftData

@Model
class FavoriteMovie {
    var id: Int
    var title: String
    var posterPath: String?
    var voteAverage: Double
    var releaseDate: String
    
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.voteAverage = movie.voteAverage
        self.releaseDate = movie.releaseDate
    }
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}
