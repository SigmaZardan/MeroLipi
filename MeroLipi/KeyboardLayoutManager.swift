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
    case numerical
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
            case .numerical:
                return KeyboardLayout(
                    rows: numericalLayout,
                    secondLastRow: numericalLayoutSecondLastLayout
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
        ["१", "२", "३", "४", "५", "६", "७", "८", "९", "०", "ं"],
        ["ो", "।", "॥", "त्र", "ऐ", "ए", "ई", "इ","ऊ", "़", "ै"],
        ["न्ह", "क्ष", "ओ", "ँ", "ह्र", "ज्ञ", "ह", "श्र", "ी", "अं", "ू"]
    ]

    private let secondarySecondLastLayout: [String] = [
        "अ:", "ॐ", "ऋ", "आ", "त्त", "द्व", "ः", "ौ", "रु"
    ]

    private let numericalLayout: [[String]] = [
        ["१", "२", "३", "४", "५", "६", "७", "८", "९", "०", "+"],
        ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "^"],
        ["@", "#", "$", "%", "&", "*", "-", "=", "(", ")", "|"]
    ]

    private let numericalLayoutSecondLastLayout: [String] = [
        ",", "!", ":", ";", "'", "/", "?", ",", "`"
    ]
}

