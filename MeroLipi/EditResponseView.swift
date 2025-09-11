//
//  EditResponseView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 11/09/2025.
//

import SwiftUI

struct EditResponseView: View {
    @Bindable var response: AIResponse
    @FocusState var isFocused: Bool
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            VStack {
                TextField(
                    "\(response.response)",
                    text: $response.response,
                    axis: .vertical
                )
                    .lineLimit(4)
                    .font(.title3)
                    .padding()
                    .background(Color.indigo.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .disableAutocorrection(true)
                    .focused($isFocused)
            }
            .padding()
        }
        .navigationTitle("Edit Translation")
        .toolbar {
            if isFocused {
                Button("Save") {
                    isFocused = false
                }
            }
        }
    }
}

#Preview {
    @Previewable  var response: AIResponse = AIResponse.dummyResponse
    EditResponseView(response: response)
}
