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
        ZStack {
            AppColors.background.ignoresSafeArea()
            VStack {
                Text("Saved Translations")
                    .titleText()

                List {
                    ForEach(viewModel.responses) { data in
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
                    .onDelete(perform: viewModel.deleteResponse)
                }.scrollContentBackground(.hidden)
            }
        }.onAppear {
            viewModel.fetchResponses()
        }
    }
}

#Preview {
    ResponseView()
}
