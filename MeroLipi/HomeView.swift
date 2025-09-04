//
//  HomeView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI

struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(AppColors.titleAndButtonColor)
            .fontWeight(.bold)
            .padding(.top, 40)
    }
}

extension View {
    func titleText() -> some View {
        modifier(TitleText())
    }
}



struct WelcomeTextAndImageView: View {
    @Environment(\.colorScheme) var colorScheme
    var imageName: String {
        colorScheme == .dark ? "home_screen_dark_image" : "home_screen_light_image"
    }
    var body: some View {
        VStack {
            Text("Welcome To Merolipi")
                .titleText()

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
                .tint(AppColors.titleAndButtonColor)
        }
        .padding()
    }
}

struct HomeView: View {
    var body: some View {
            ScrollView {
                    WelcomeTextAndImageView()
                    VStack {
                        TitleAndButtonComponentView(
                            title: "Add Mero Lipi keyboard?",
                            buttonLabel: "Settings",
                        ) {
                            // navigate to the first screen
                            // if the keyboard extension has already been installed then
                            // go to the second page
                            // otherwise go to the first page
                        }
                        InstructionView(
                            instruction: "Tap on Translation tab for Roman To Nepali",
                            instructionPortionToBold: "Roman To Nepali"
                        )
                    }

            }
    }
}

#Preview {
    HomeView()
}
