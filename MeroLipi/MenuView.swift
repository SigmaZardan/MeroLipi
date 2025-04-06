//
//  MenuView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI

struct MenuView: View {
    @Binding var isDarkMode: Bool

    var body: some View {
        VStack {
            Toggle("Dark Mode", isOn: $isDarkMode)
            Spacer()
            Text("This is home screen.")
        }.padding()
    }
}

#Preview {
    MenuView(isDarkMode: .constant(false))
}
