//
//  Theme.swift
//  CineWords
//
//  Created by Baran on 25.06.2026.
//

import SwiftUI

extension Color{
    static let cineBackground  = Color(hex: "0D0D0D")
    static let cineSurface = Color(hex: "1A1A1A")
    static let cineAccent  = Color(hex: "E50914")
    static let cineText = Color.white
    static let cineSubtext = Color(hex: "AAAAAA")
    
}

extension Color{
    
    init(hex: String){
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
    
}
