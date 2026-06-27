//
//  ContentView.swift
//  CineWords
//
//  Created by Baran on 25.06.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Keşfet", systemImage: "film")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favoriler", systemImage: "heart.fill")
                }
        }
        .tint(Color.cineAccent)
        .preferredColorScheme(.dark)
    }
}
