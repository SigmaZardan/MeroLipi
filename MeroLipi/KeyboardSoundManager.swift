//
//  KeyboardSoundManager.swift
//  MeroLipiKeyboard
//
//  Created by Bibek Bhujel on 14/04/2025.
//

import AVFoundation
import AudioToolbox


enum KeySoundType {
    case alphabet
    case delete
    case toolButton
}

class KeyboardSoundManager {
    static let shared = KeyboardSoundManager()

    private init() {} // Singleton

    func playSound(for type: KeySoundType) {
        let soundID: SystemSoundID

        switch type {
        case .alphabet:
            soundID = 1104
        case .delete:
            soundID = 1155
            case .toolButton:
            soundID = 1105
        }

        AudioServicesPlaySystemSound(soundID)
    }
}

