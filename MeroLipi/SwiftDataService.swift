//
//  SwiftDataService.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 05/05/2025.
//

import Foundation
import SwiftData
import UIKit

class SwiftDataService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    let pasteBoard = UIPasteboard.general


    @MainActor
    static let shared = SwiftDataService()

    @MainActor
    private init() {
            // Change isStoredInMemoryOnly to false if you would like to see the data persistance after kill/exit the app
        self.modelContainer = try! ModelContainer(
            for: AIResponse.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: false)
        )
            self.modelContext = modelContainer.mainContext
        }

    func fetchAIResponses() -> [AIResponse] {
            do {
                return try modelContext.fetch(FetchDescriptor<AIResponse>())
            } catch {
                fatalError(error.localizedDescription)
            }
        }

    func addResponse(_ response: AIResponse) {
        let responses = fetchAIResponses()
        var responseExists = false
        for item in responses {
            if item.response == response.response {
                responseExists = true
            }
        }
            do {
                if !responseExists {
                    modelContext.insert(response)
                } else {
                    print("Response already exists!")
                }
                try modelContext.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }


    func deleteResponse(_ response: AIResponse) {
        modelContext.delete(response)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
