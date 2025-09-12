//
//  MenuView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI
import StoreKit

struct MenuView: View {
    @Environment(\.requestReview) var requestReview

    var body: some View {
        NavigationStack {
            List {
                Section("App Info") {
                    Button{
                        requestReview()
                    } label: {
                        Label("Rate Us", systemImage: "star.fill")
                    }
                    .listRowBackground(AppColors.cardBackgroundColor)

                    NavigationLink(destination: AboutView()) {
                        Label("About", systemImage: "info.circle.fill")
                    }
                    .listRowBackground(AppColors.cardBackgroundColor)
                }

                Section("App Support"){

                    NavigationLink(destination: HowToUseView()) {
                        Label("How to Use", systemImage: "keyboard.fill")
                    }
                    .listRowBackground(
                        AppColors.cardBackgroundColor
                    )

                    NavigationLink(destination: ContactView()) {
                        Label("Contact Us", systemImage: "envelope.fill")
                    }
                    .listRowBackground(
                        AppColors.cardBackgroundColor
                    )
                }
            }
            .scrollContentBackground(.hidden)
            .background(AppColors.background)
            .navigationTitle("Privacy & Settings")
        }
    }
}

#Preview {
    MenuView()
}
