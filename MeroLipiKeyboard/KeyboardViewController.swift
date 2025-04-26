//
//  KeyboardViewController.swift
//  MeroLipiKeyboard
//
//  Created by Bibek Bhujel on 14/04/2025.
//

import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {
    @State private var isEmpty = false
    override func viewDidLoad() {
        super.viewDidLoad()

        let meroLipiKeyboardViewController = UIHostingController(
            rootView: MeroLipiKeyboardView(
                insertText: { [weak self] text in
                    guard let self else { return }
                    self.textDocumentProxy.insertText(text)
                    if text.isEmpty == true {
                        isEmpty = true
                    }
                },
                deleteText: { [weak self] in
                    guard let self,
                          self.textDocumentProxy.hasText else { return }

                    self.textDocumentProxy.deleteBackward()
                },
                needsInputModeSwitchKey: self.needsInputModeSwitchKey,
                nextKeyboardAction: #selector(self.handleInputModeList(from:with:)),
                keyboardHeight: 275,
                onDone: { [weak self] in
                    guard let self else {return}
                    self.textDocumentProxy.insertText("\n")
                },
            ))

        // default to white
        meroLipiKeyboardViewController.view.backgroundColor = .clear

        let meroLipiKeyboardView = meroLipiKeyboardViewController.view!
        meroLipiKeyboardView.translatesAutoresizingMaskIntoConstraints = false



        self.addChild(meroLipiKeyboardViewController)
        self.view.addSubview(meroLipiKeyboardView)
        meroLipiKeyboardViewController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            meroLipiKeyboardView.leftAnchor.constraint(equalTo: view.leftAnchor),
            meroLipiKeyboardView.topAnchor.constraint(equalTo: view.topAnchor),
            meroLipiKeyboardView.rightAnchor.constraint(equalTo: view.rightAnchor),
            meroLipiKeyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }

}
