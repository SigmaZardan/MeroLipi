//
//  KeyboardLayoutManager.swift
//  MeroLipiKeyboard
//
//  Created by Bibek Bhujel on 14/04/2025.
//

import Foundation


struct KeyboardLayout {
    let rows: [[String]]
    let secondLastRow: [String]
}

enum KeyboardLayoutType {
    case primary
    case secondary
}

class KeyboardLayoutManager {
    static let shared = KeyboardLayoutManager()
    private init() {}

    func getLayout(for type: KeyboardLayoutType) -> KeyboardLayout {
        switch type {
        case .primary:
            return KeyboardLayout(
                rows: primaryLayout,
                secondLastRow: primarySecondLastLayout
            )
        case .secondary:
            return KeyboardLayout(
                rows: secondaryLayout,
                secondLastRow: secondarySecondLastLayout
            )
        }
    }

    private let primaryLayout: [[String]] = [
        ["ञ", "घ", "ङ", "झ", "छ", "ट", "ठ", "ड", "ढ", "ण", "्"],
        ["ध", "भ", "च", "त", "थ", "ग", "प", "य", "उ", "ृ", "े"],
        ["ब", "क", "म", "ा", "न", "ज", "व", "प", "ि", "स", "ु"]
    ]

    private let primarySecondLastLayout: [String] = [
        "श", "ह", "अ", "ख", "द", "ल", "फ", ",", "र"
    ]

    private let secondaryLayout: [[String]] = [
        ["क्ष", "त्र", "ज्ञ", "॥", "ड़", "इ", "ऐ", "ॐ", "ऽ", "/", "+"],
        ["१", "२", "३", "४", "५", "६", "७", "८", "९", "०", "₹"],
        ["@", "#", "$", "%", "&", "*", "-", "=", "(", ")", "\""]
    ]

    private let secondarySecondLastLayout: [String] = [
        "!", "ँ", ";", "'", ".", "_", "?", ",", "`"
    ]
}

