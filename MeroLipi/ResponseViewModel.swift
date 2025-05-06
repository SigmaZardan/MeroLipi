//
//  ResponseViewModel.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/05/2025.
//

import Foundation
import UIKit
import SwiftData


extension  ResponseView {
    @Observable
    class ViewModel {
        private let dataSource: SwiftDataService
        var responses: [AIResponse]
        init(dataSource: SwiftDataService) {
            self.dataSource = dataSource
            self.responses = dataSource.fetchAIResponses()
        }
        
        func deleteResponse(at offsets: IndexSet) {
            for offset in offsets {
                let response = responses[offset]
                dataSource.deleteResponse(response)
            }
        }
        
        func copyToClipBoard(_ response: String) {
            dataSource.pasteBoard.string = response
        }

        func fetchResponses() {
            responses = dataSource.fetchAIResponses()
        }
    }
}
