//
//  HowToUse.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 12/09/2025.
//

import SwiftUI

struct HowToUseView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                Text("How to Use Nepali Keyboard")
                    .font(.title2)
                    .bold()

                Group {
                    Text("1. Enable the Keyboard")
                        .font(.headline)
                    Text("""
- Open **Settings** → **General** → **Keyboard** → **Keyboards** → **Add New Keyboard**.
- Select **MeroLipiKeyboard** from the list.
""")
                }

                Group {
                    Text("2. Allow Full Access (Optional)")
                        .font(.headline)
                    Text("""
Full Access is required for Roman → Devanagari conversion. 
You can enable it from **Settings → Keyboards → Nepali Keyboard → Allow Full Access**.
""")
                }

                Group {
                    Text("3. Switch Keyboard")
                        .font(.headline)
                    Text("""
While typing, tap the 🌐 (globe) icon on your keyboard and select **Nepali Keyboard**.
""")
                }

                Divider()

                // Example conversion box
                VStack(alignment: .leading, spacing: 8) {
                    Text("Example")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Roman:")
                            Spacer()
                            Text("mero naam")
                                .italic()
                        }
                        HStack {
                            Text("Devanagari:")
                            Spacer()
                            Text("मेरो नाम")
                                .bold()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(AppColors.cardBackgroundColor)
                    .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("How to Use")
        .navigationBarTitleDisplayMode(.inline)
        .background(AppColors.background.ignoresSafeArea())
    }
}

#Preview {
    NavigationStack {
        HowToUseView()
    }
}
