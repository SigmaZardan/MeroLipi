//
//  AboutView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 18/05/2025.
//

import SwiftUI

struct AboutView: View {
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // App title
                Text("About Merolipi Keyboard")
                    .font(.title2)
                    .bold()

                // Description
                Text("""
Nepali Keyboard helps you type in Nepali quickly and easily. 
Type Romanized Nepali (like *mero naam*) and it will automatically convert to Devanagari (मेरो नाम). 
Designed for simplicity, speed, and accuracy.
""")
                .font(.body)

                Divider()

                // Version info
                HStack {
                    Text("Version")
                    Spacer()
                    Text(appVersion)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background.ignoresSafeArea())
    }
}

#Preview {
    AboutView()
}
