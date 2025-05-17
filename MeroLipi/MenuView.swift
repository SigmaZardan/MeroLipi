//
//  MenuView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI
import StoreKit

struct MenuView: View {
    @Binding var isDarkMode: Bool
    @Environment(\.requestReview) var requestReview

    var body: some View {
            VStack(alignment:.leading, spacing: 8){
                Toggle("Dark Mode", isOn: $isDarkMode)
                Button("Rate Us") {
                    requestReview()
                }
                    NavigationLink("Privacy") {
                        Text("pro pro ")
                    }
                Spacer()
            }.frame(maxWidth: .infinity)
                .padding()
                .background(AppColors.background)
    }
}

#Preview {
    MenuView(isDarkMode: .constant(false))
}
