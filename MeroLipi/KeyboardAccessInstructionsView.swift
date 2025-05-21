//
//  KeyboardAccessInstructionsView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 12/04/2025.
//

import SwiftUI
import UIKit


struct OnboardingStepHeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    let stepNumber: Int

    var imageName: String {
        colorScheme == .light ? "home_screen_light_image": "home_screen_dark_image"
    }

    var body: some View {
        VStack{
                Image(systemName: "keyboard.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(
                        AppColors.keyboardForegroundColor
                    )
                    .padding()

            Text("Step \(stepNumber) of 2: Setup Mero Lipi")
                .font(.title2.bold())
        }
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
    }
}

struct FirstStepInstructionView: View {
    var onStartedClick: (() -> Void) = {}
    var body: some View {
        ScrollView {
            OnboardingStepHeaderView(stepNumber: 1)

            InstructionView(
                instruction: "Tap Keyboards",
                instructionPortionToBold: "Keyboards"
            )
            InstructionView(
                iconName:"switch.2",
                instruction: "Turn on MeroLipiKeyboard",
                instructionPortionToBold: "MeroLipiKeyboard"
            )

            AcknowledgementView()
            SetupButton(buttonTitle: "Get Started", onClick: { onStartedClick()})
        }
    }
}

struct SecondStepInstructionView: View {
    @FocusState private var isFieldFocused: Bool
    @State private var text: String = ""
    let onFinishSetupClicked: () -> Void
    var body: some View {
        ScrollView {

            OnboardingStepHeaderView(stepNumber: 2)
            InstructionView(iconName: "globe", instruction: "Tap and hold Globe icon", instructionPortionToBold: "Globe")
            InstructionView(instruction: "Tap MeroLipiKeyboard to switch keyboards", instructionPortionToBold: "MeroLipiKeyboard")
            InstructionView(iconName: "keyboard",instruction: "Try typing in Nepali", instructionPortionToBold: "Nepali")
            TextField("Type here", text: $text)
                .font(.title3)
                .padding()
                .background(Color.indigo.opacity(0.2), in: Capsule())
                .disableAutocorrection(true)
                .padding()

            if text.isEmpty == false {
                HightlightedInstructionTextView(fullText: "Use Globe icon to switch between keyboards", textToBold: "keyboards")
                SetupButton(
                    buttonTitle: "Finish Setup",
                    onClick: onFinishSetupClicked
                )
            }
        }
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



#Preview {
    FirstStepInstructionView(onStartedClick: {})
}

#Preview {
    SecondStepInstructionView(onFinishSetupClicked: {})
}
