//
//  TranslatorView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI
import GoogleGenerativeAI




struct TranslatorView: View {
      @State private var viewModel = ViewModel()


    @FocusState var isFocused:Bool
    let errorMessage = "Oops! something went wrong.☹️"


    var body: some View {
        VStack {

            Text("Roman To Nepali")
                .font(.title)
                .foregroundStyle(AppColors.titleAndButtonColor)
                .fontWeight(.bold)
                .padding(.top, 40)



            ZStack{
                ScrollView{
                    Text(viewModel.response)
                        .font(.title2)
                        .textSelection(.enabled)
                }

                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                        .scaleEffect(4)
                }

                if viewModel.isError {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.red)

                        Text(errorMessage)
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .padding()

                        Button(action: {
                            viewModel.handleRetry()
                        }) {
                            Text("Try Again")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding()
                }

            }



            if viewModel.response.isEmpty == false {
                Button {
                    viewModel.copyToClipBoard()
                } label: {
                    Image(systemName: "document.on.document")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40)
                }
                .alert(
                    "Copied!",
                    isPresented: $viewModel.isCopyAlertPresented,
                    actions: { Button("Ok") { }
                    })
                .padding()
            }

            HStack {
                TextField(
                    "Roman text",
                    text: $viewModel.userPrompt,
                    axis: .vertical
                )
                .lineLimit(2)
                .font(.title3)
                .padding()
                .background(Color.indigo.opacity(0.2), in: Capsule())
                .disableAutocorrection(true)
                .onSubmit {
                    viewModel.generateResponse()
                }
                .focused($isFocused)

                Button {
                    viewModel.generateResponse()
                    isFocused = false
                } label: {

                    Image(systemName: "arrowshape.up.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40)
                        .disabled(viewModel.userPrompt.isEmpty)
                        .tint(
                            viewModel.userPrompt.isEmpty ? nil : AppColors.titleAndButtonColor
                        )
                }
            }
        }
        .padding()
    }
}

#Preview {
    TranslatorView()
}
