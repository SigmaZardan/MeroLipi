//
//  HomeView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI


struct WelcomeTextAndImageView: View {
    @Environment(\.colorScheme) var colorScheme
    var imageName: String {
        colorScheme == .dark ? "home_screen_dark_image" : "home_screen_light_image"
    }
    var body: some View {
        VStack {
            Text("Welcome To Merolipi")
                .font(.largeTitle)
                .foregroundStyle(AppColors.titleAndButtonColor)
                .fontWeight(.bold)
                .padding(.top, 40)

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
    let onAddMeroLipiClicked: () -> Void
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
                            onAddMeroLipiClicked()
                        }
                        InstructionView(
                            instruction: "Wanna try Roman to Nepali translation?",
                            instructionPortionToBold: "Roman to Nepali translation?"
                        )

                        Image(systemName:"arrowshape.down.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 60)
                            .foregroundStyle(.indigo)
                    }

            }
    }
}

#Preview {
    HomeView(onAddMeroLipiClicked: {})
}
