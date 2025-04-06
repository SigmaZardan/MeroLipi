//
//  ContentView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("appTheme") private var isDarkMode = false
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView(isDarkMode: isDarkMode)
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
