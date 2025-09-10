//
//  ContentView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI
import SwiftData


@Observable
class PathStore  {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    // create a path to save the navigation path
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else {
            return
        }
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(representation)
            try data.write(to: savePath)
        }
        catch {
            print("Failed to save navigation data.")
        }
    }
}




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
                    .background(AppColors.background)
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
