//
//  HomeView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("Welcome, bibek!")
                        .font(.largeTitle.bold())
                    Image(decorative: "home_screen_light_image")
                    .resizable()
                    .scaledToFit()
                }
                VStack {
                    HStack {
                        Text("Add Mero Lipi ?")
                            .font(.title2)
                        Spacer()
                        Button {
                        }label: {
                            Text("Settings")
                        }.buttonStyle(.borderedProminent)
                    }
                    .padding()
                    HStack {
                        Text("Translate Roman to Nepali?")
                            .font(.title2)
                        Spacer()
                        Button {
                        } label: {
                            Text("Translate")
                        }.buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
            }
            .frame(maxHeight: .infinity)
            .background(AppColors.background)
            .navigationTitle("MERO LIPI")
        }
    }
}

#Preview {
    HomeView()
}
