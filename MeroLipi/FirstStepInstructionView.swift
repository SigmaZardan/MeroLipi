//
//  FirstStepInstructionView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 03/09/2025.
//

import SwiftUI

struct FirstStepInstructionView: View {
    @Binding var selectedTab: Int
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0){
                    OnboardingStepHeaderView(stepNumber: 1)
                    InstructionView(iconName: "hand.tap.fill", instruction: "Tap on Keyboards", instructionPortionToBold: "Keyboards")
                    InstructionView(iconName: "switch.2", instruction: "Turn on MeroLipi", instructionPortionToBold: "MeroLipi")
                    AcknowledgementView()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    SetupButton(buttonTitle: "Get Started", onClick:openSettings)
                        .padding(.vertical, 3)
                }
            }
        }
        .onAppear {
            if isMeroLipiInstalled() {
                selectedTab = 1
            }
        }

    }
    
    func openSettings() {
            if let url = URL(
                string: UIApplication.openSettingsURLString
            ) {
                UIApplication.shared.open(url)
            }
    }

    func isMeroLipiInstalled() -> Bool {
        if let keyboards = UserDefaults.standard.array(forKey: "AppleKeyboards") as? [String] {
            if keyboards
                .firstIndex(of: "bibek.MeroLipi.MeroLipiKeyboard") != nil {
                return true
            }
        }
        return false
    }
}

#Preview {
    FirstStepInstructionView(selectedTab: .constant(0))
}

