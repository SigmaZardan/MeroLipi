//
//  ResponseView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/05/2025.
//

import SwiftUI

struct ResponseView: View {
    @State private var viewModel = ViewModel(
        dataSource: SwiftDataService.shared
    )

    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.background.ignoresSafeArea()
                VStack {
                    if viewModel.responses.isEmpty {
                        ContentUnavailableView {
                            Label("No Translations", systemImage: "document.fill")
                        } description: {
                            Text("The translations you save will appear here.")
                        }
                    } else {
                        List {
                            ForEach(viewModel.responses) { data in
                                NavigationLink(value: data) {
                                    Text(data.response)
                                        .listRowBackground(Color.clear)
                                        .textSelection(.enabled)
                                        .contextMenu {
                                            Button {
                                                viewModel.copyToClipBoard(data.response)
                                            }label: {
                                                Label("Copy", systemImage: "document.on.document")
                                            }
                                        }
                                }
                                .listRowBackground(
                                    AppColors.cardBackgroundColor
                                )

                            }
                            .onDelete(perform: viewModel.deleteResponse)


                        }.scrollContentBackground(.hidden)
                            .navigationDestination(for:AIResponse.self) { response in
                                EditResponseView(response:response)
                            }
                    }
                }
            }.onAppear {
                viewModel.fetchResponses()
            }
        }
    }
}

#Preview {
    ResponseView()
}
