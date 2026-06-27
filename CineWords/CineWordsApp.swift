//
//  CineWordsApp.swift
//  CineWords
//
//  Created by Baran on 25.06.2026.
//

import SwiftUI
import SwiftData

@main
struct CineWordsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: FavoriteMovie.self)
    }
}
