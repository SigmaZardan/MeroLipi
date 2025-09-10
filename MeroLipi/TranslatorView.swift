//
//  TranslatorView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI
import GoogleGenerativeAI
import SwiftData


enum ButtonType {
    case save, copy


    var buttonLabel: String {
        switch self {
            case .save:
                "Save"
            case .copy:
                "Copy"
        }
    }


    var systemImageName:String {
        switch self {
            case .save:
                "square.and.arrow.down.on.square"
            case .copy:
                "document.on.document"
        }
    }
}


struct TranslatorView: View {
    @State private var viewModel = ViewModel(
        dataSource: SwiftDataService.shared
    )

    @FocusState var isFocused:Bool
    let errorMessage = "Oops! something went wrong.☹️"

    var body: some View {
        NavigationStack{
            VStack {
                ZStack{
                    ScrollView{
                        if !viewModel.response.isEmpty {
                            VStack(alignment: .leading){
                                Text(viewModel.response)
                                    .font(.title2)
                                    .padding()

                                if viewModel.response != AIModelData.defaultResponse {
                                    ResponseButtonsView(viewModel: viewModel)
                                }
                            }
                            .frame(
                                maxWidth: .infinity
                            )
                            .background(Color.indigo.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .contextMenu {
                                ContextMenuButtonsView(
                                    viewModel: viewModel
                                )
                            }
                            .padding()
                        }
                    }

                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                            .scaleEffect(4)
                    }
                }

                VStack {
                    HStack{
                        TextField(
                            "Try typing in Roman",
                            text: $viewModel.userPrompt,
                            axis: .vertical
                        )
                        .lineLimit(2)
                        .font(.title3)
                        .padding()
                        .background(Color.indigo.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .disableAutocorrection(true)
                        .focused($isFocused)


                        Button {
                            viewModel.generateResponse()
                            isFocused = false
                        } label: {
                            Image(systemName: "arrowshape.up.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 40)
                                .tint(
                                    viewModel.userPrompt.isEmpty ? nil : AppColors.titleAndButtonColor
                                )
                        }
                        .disabled(
                            viewModel.userPrompt
                                .trimmingCharacters(
                                    in: .whitespacesAndNewlines
                                ).isEmpty
                        )
                    }
                    .padding()
                }
            }
            .background(AppColors.background)
            .navigationTitle("Roman To Nepali")
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
            .alert("Saved!", isPresented: $viewModel.isSaved,
                   actions: {
                Button("Ok") { viewModel.isSaved = true }
            }
            )
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}


struct ContextMenuButtonsView: View {
    let viewModel: TranslatorView.ViewModel
    var body: some View {
        VStack {
            ButtonView( onButtonClick: { viewModel.saveResponse() },buttonType: .save)
            ButtonView(onButtonClick: { viewModel.copyToClipBoard() },buttonType: .copy)
        }
        .labelStyle(.titleAndIcon)
    }
}


struct ResponseButtonsView: View {
    let viewModel: TranslatorView.ViewModel
    var body: some View {
        HStack {
            ButtonView( onButtonClick: { viewModel.saveResponse() },buttonType: .save)
            ButtonView(onButtonClick: { viewModel.copyToClipBoard() },buttonType: .copy)
            Spacer()
        }
        .labelStyle(.iconOnly)
        .padding([.horizontal, .bottom])
    }
}




struct ButtonView: View {
    let onButtonClick: () -> Void
    let buttonType: ButtonType

    var body: some View {
        Button {
            onButtonClick()
        } label: {
            Label(buttonType.buttonLabel, systemImage: buttonType.systemImageName)
        }
    }
}


#Preview {
    TranslatorView()
}
