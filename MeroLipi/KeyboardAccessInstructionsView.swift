//
//  KeyboardAccessInstructionsView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 12/04/2025.
//

import SwiftUI
import UIKit


struct OnboardingStepHeaderView: View {

    let stepNumber: Int

    var imageName: String {
        "home_screen_light_image"
    }

    var body: some View {
        VStack(alignment: .leading){
                Image(systemName: "keyboard.badge.eye.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(
                        AppColors.keyboardForegroundColor
                    )

            Text("Step \(stepNumber) of 2: Setup Mero Lipi")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}


struct InstructionView: View {
    var iconName: String = "hand.tap.fill"
    let instruction: String
    let instructionPortionToBold: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundStyle(AppColors.titleAndButtonColor)
            HightlightedInstructionTextView(
                fullText: instruction,
                textToBold:instructionPortionToBold
            )
            Spacer()
        }.padding()
            .font(.title2)
    }
}

struct HightlightedInstructionTextView: View {
    let fullText: String
    let textToBold: String
    var separatedText: [String] {
        fullText.components(separatedBy: textToBold)
    }
    var body: some View {
        Text(separatedText[0]) + Text(textToBold).bold()
    }
}


struct AcknowledgementView: View {
    var body: some View {
        VStack(alignment: .leading){

            HightlightedInstructionTextView(fullText: "Your go-to keyboard for typing in your native language.", textToBold:"native language.")
                .padding(.vertical)

            HightlightedInstructionTextView(fullText: "Express yourself fluently in your mother tongue.", textToBold: "mother tongue.")
        }
        .font(.title3)
    }
}





struct SetupButton: View {
    let buttonTitle: String
    let onClick: () -> Void
    var body: some View {
        Button {
            onClick()
        }label: {
            Text(buttonTitle)
                .font(.title2.bold())
                .padding()
                .frame(maxWidth: .infinity)

        }.buttonStyle(.borderedProminent)
            .tint(AppColors.titleAndButtonColor)
            .padding()
    }
}

struct KeyboardAccessInstructionsView: View {
    @Binding var value: Bool
    var body: some View {
        ScrollView {
        }
        .frame(maxWidth: .infinity)
        .background(AppColors.background)

    }


}



