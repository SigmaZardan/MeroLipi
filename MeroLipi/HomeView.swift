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



struct WelcomeImageView: View {
    @Environment(\.colorScheme) var colorScheme
    let height: CGFloat

    var body: some View {
            Image(decorative: "home_screen_light_image")
                .resizable()
                .scaledToFit()
                .frame( maxHeight: height)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                .padding()
                .padding()
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

    init() {
        UINavigationBar
            .appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
    }

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ZStack {
                    AppColors.background.ignoresSafeArea()
                    ScrollView {
                        WelcomeImageView(height: proxy.size.height * 0.4)
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
                .navigationTitle("Home View")
            }

        }
    }
}

#Preview {
        HomeView()
}
