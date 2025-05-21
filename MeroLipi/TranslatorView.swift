//
//  TranslatorView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI
import GoogleGenerativeAI
import SwiftData



struct TranslatorView: View {
    @State private var viewModel = ViewModel(
        dataSource: SwiftDataService.shared
    )

    @FocusState var isFocused:Bool
    let errorMessage = "Oops! something went wrong.☹️"

    var body: some View {
        VStack {
            HStack {
                Spacer()
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
            Text("Roman To Nepali")
                .titleText()


            ZStack{
                ScrollView{
                    Text(viewModel.response)
                        .font(.title2)
                        .padding()
                        .contextMenu {
                            Button {
                                viewModel.copyToClipBoard()
                            }label: {
                                Label("Copy", systemImage: "document.on.document")
                            }

                            Button {
                                viewModel.saveResponse()
                            } label: {
                                Label("Save", systemImage: "document.on.document")
                            }
                        }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                        .scaleEffect(4)
                }
            }

            VStack {
                if viewModel.response.isEmpty == false {
                    Button {
                        viewModel.copyToClipBoard()
                    } label: {
                        Image(systemName: "document.on.document")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 40)
                    }
                    .padding()
                }


                HStack{
                    TextField(
                        "Try typing in Roman",
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
        }
        .alert(
            "Copied!",
            isPresented: $viewModel.isCopyAlertPresented,
            actions: { Button("Ok") { }
            })
        .alert(errorMessage,
               isPresented:  $viewModel.isError,
               actions: {
            Button("Retry", action: viewModel.handleRetry)
            Button("Ok") {
                viewModel.resetLoading()
                viewModel.resetPrompt()
            }
        }
        )
        .padding()
    }
}


#Preview {
    TranslatorView()
}
