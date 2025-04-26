//
//  Test.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 17/04/2025.
//
import SwiftUI
struct NavBav: View {
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            // Screen A (Starting screen)
            ScreenA(navigateToB: {
                navigationPath.append("B")
            })
            .navigationDestination(for: String.self) { destination in
                switch destination {
                case "B":
                    ScreenB(navigateToC: {
                        navigationPath.append("C")
                    })
                case "C":
                    ScreenC()
                default:
                    EmptyView()
                }
            }
        }
    }
}

struct ScreenA: View {
    var navigateToB: () -> Void

    var body: some View {
        VStack {
            Text("Screen A")
            Button("Next to B") {
                navigateToB()
            }
        }
    }
}

struct ScreenB: View {
    var navigateToC: () -> Void

    var body: some View {
        VStack {
            Text("Screen B")
            Button("Next to C") {
                navigateToC()
            }
        }
    }
}

struct ScreenC: View {
    var body: some View {
            TabView {
                Tab("Home", systemImage: "house") {
                }
                Tab("Translate", systemImage: "character.book.closed") {

                }
                Tab("Menu", systemImage: "list.bullet") {
                }
            }
        }
}

#Preview {
    NavBav()
}
