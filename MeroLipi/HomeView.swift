//
//  HomeView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI


struct WelcomeTextAndImageView: View {
    let name: String
    let isDarkMode: Bool

    var imageName: String {
        isDarkMode ? "home_screen_dark_image" : "home_screen_light_image"
    }
    var body: some View {
        VStack {
            Text("Welcome, \(name)!")
                .font(.largeTitle.bold())
            Image(decorative: imageName)
                .resizable()
                .scaledToFit()
        }
    }
}

struct TitleAndButtonComponentView: View {
    let title: String
    let buttonLabel: String
    let onClick: () -> Void
    var body: some View {
        HStack {
            Text(title)
                .font(.title3)
                .lineLimit(1)
            Spacer()
            Button(buttonLabel){
                onClick()
            }.buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct HomeView: View {
    let isDarkMode: Bool
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    WelcomeTextAndImageView(name: "bibek", isDarkMode: isDarkMode)
                    VStack {
                        TitleAndButtonComponentView(
                            title: "Add Mero Lipi keyboard?",
                            buttonLabel: "Settings",
                        ) {

                        }
                        TitleAndButtonComponentView(
                            title: "Translate Roman to Nepali?",
                            buttonLabel: "Translate",
                        ) {

                        }
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .background(AppColors.background)
            .navigationTitle("MERO LIPI")
        }
    }
}

#Preview {
    HomeView(isDarkMode: false)
}
