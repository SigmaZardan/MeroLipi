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
            VStack(alignment:.leading, spacing: 8){
                Button("Rate Us") {
                    requestReview()
                }
                    NavigationLink("About") {
                        AboutView()
                    }
                Spacer()
            }.frame(maxWidth: .infinity)
                .padding()
                .background(AppColors.background)
    }
}

#Preview {
    MenuView()
}
