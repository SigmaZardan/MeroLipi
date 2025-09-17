//
//  ContentView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI
import SwiftData






struct ContentView: View {
    @AppStorage("showOnboardingScreenId") private var showingOnboardingScreen = true
    var body: some View {
        MainView()
            .sheet(isPresented: $showingOnboardingScreen) {
                OnboardingScreen(
                    showingOnboardingScreen: $showingOnboardingScreen
                )
            }
        }
    }
    



struct MainView: View {

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            
            Tab("Translate", systemImage: "character.book.closed") {
                TranslatorView()
            }
            
            Tab("Saved", systemImage: "doc.text.fill") {
                ResponseView()
            }
            
            Tab("Menu", systemImage: "list.bullet") {
                MenuView()
            }
            
        }.tint(AppColors.titleAndButtonColor)
    }
}


#Preview {
    ContentView()
}
