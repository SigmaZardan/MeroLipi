//
//  ApiResponse.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 05/05/2025.
//

import Foundation
import SwiftData


@Model
class AIResponse {
    var id: UUID = UUID()
    var response: String
    var date = Date.now

    init( response: String) {
        self.response = response
    }


    static let dummyResponse = AIResponse(response: "के छ तिम्रो खबर?")
    static let dummyResponses: [AIResponse] = [
        AIResponse(response: "के छ तिम्रो खबर?"),
        AIResponse(response: "Mero ta thikai xa sathi ko chai k xa ho"),
        AIResponse(response: "Hawa kura ta garna vayena ni yaar"),
        AIResponse(response: "lala thikai xa mero pani")
    ]
}

