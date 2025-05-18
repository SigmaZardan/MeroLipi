//
//  AboutView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 18/05/2025.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            NavigationLink(destination: Text("Services")) {
                HStack {
                    Text("Terms of service")
                    Spacer()
                }
            }
            NavigationLink("Privacy Policy") {
                Text("Privacy policy")
            }
            NavigationLink("Licenses") {
                Text("Licenses")
            }
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(AppColors.background)
    }
}

#Preview {
    AboutView()
}
