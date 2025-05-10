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


enum Screen: Hashable, Codable{
    case first
    case second
    case main
}


struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("appTheme") private var isDarkMode = false
    @AppStorage("KeyboardInstalled") private var isMeroLipiInstalled = false
    @State private var pathStore = PathStore()
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            FirstStepInstructionView(onStartedClick: {
                openSettings()
            })
            .frame(maxWidth: .infinity)
            .background(AppColors.background)
            .onChange(of: scenePhase) {
                if scenePhase == .active {
                    checkForKeyboardExtension()
                    if isMeroLipiInstalled == true && pathStore.path.isEmpty == true {
                        pathStore.path.append(Screen.second)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Skip") {
                        pathStore.path.append(Screen.main)
                    }
                }
            }
            .navigationDestination(for: Screen.self) { newScreen in
                switch newScreen  {
                    case .first: FirstStepInstructionView()
                            .background(AppColors.background)
                        
                    case .second: SecondStepInstructionView(
                        onFinishSetupClicked: {pathStore
                            .path.append(Screen.main)})
                    .background(AppColors.background)
                        
                    case .main: MainView(isDarkMode: $isDarkMode) {
                        if isMeroLipiInstalled == true {
                            // navigate to the second screen
                            pathStore.path.append(Screen.second)
                        } else {
                            pathStore.path.append(Screen.first)
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                }
            } .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
    
    
    func checkForKeyboardExtension() {
        if let keyboards = UserDefaults.standard.array(forKey: "AppleKeyboards") as? [String] {
            if keyboards
                .firstIndex(of: "bibek.MeroLipi.MeroLipiKeyboard") != nil {
                isMeroLipiInstalled = true
            } else  {
                isMeroLipiInstalled = false
            }
        }
    }
    func openSettings() {
        if let url = URL(
            string: UIApplication.openNotificationSettingsURLString
        ) {
            UIApplication.shared.open(url)
        }
    }
}

struct MainView: View {
    @Binding var isDarkMode: Bool
    let onAddMeroLipiClicked: () -> Void
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView(onAddMeroLipiClicked: onAddMeroLipiClicked)
                    .background(AppColors.background)
            }
            
            Tab("Translate", systemImage: "character.book.closed") {
                TranslatorView()
                    .background(AppColors.background)
            }
            
            Tab("Saved", systemImage: "doc.text.fill") {
                ResponseView()
                    .background(AppColors.background)
            }
            
            Tab("Menu", systemImage: "list.bullet") {
                MenuView(isDarkMode:$isDarkMode )
                    .background(AppColors.background)
            }
            
        }.tint(AppColors.titleAndButtonColor)
    }
}


#Preview {
    MainView(isDarkMode: .constant(false), onAddMeroLipiClicked: {})
}

#Preview {
    ContentView()
}
