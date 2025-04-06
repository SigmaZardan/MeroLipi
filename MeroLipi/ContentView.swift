//
//  ContentView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isDarkMode = false
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            Tab("Translate", systemImage: "character.book.closed") {
                TranslatorView()
            }
            Tab("Menu", systemImage: "list.bullet") {
                MenuView(isDarkMode: $isDarkMode)
            }
        }.preferredColorScheme( isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
