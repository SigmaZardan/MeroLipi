//
//  FirstStepInstructionView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 03/09/2025.
//

import SwiftUI

struct FirstStepInstructionView: View {
    @Binding var selectedTab: Int
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0){
                    OnboardingStepHeaderView(stepNumber: 1)
                    InstructionView(
                        iconName:"square.grid.3x3.fill",
                        instruction: "Tap on Apps",
                        instructionPortionToBold: "Apps"
                    )
                    InstructionView(instruction: "Tap on MeroLipi", instructionPortionToBold:"MeroLipi")
                    InstructionView(iconName: "hand.tap.fill", instruction: "Tap on Keyboards", instructionPortionToBold: "Keyboards")
                    InstructionView(iconName: "switch.2", instruction: "Turn on MeroLipi", instructionPortionToBold: "MeroLipi")
                    AcknowledgementView()
                    Spacer()
                    SetupButton(buttonTitle: "Get Started", onClick:openSettings)
                        .padding(.vertical, 3)
                }
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if isMeroLipiInstalled() {
                    withAnimation {
                        selectedTab = 1
                    }
                }
            }
        }

    }
    
    func openSettings() {
            if let url = URL(
                string: UIApplication.openSettingsURLString
            ) {
                if UIApplication.shared.canOpenURL(url) {
                       UIApplication.shared.open(url, options: [:], completionHandler: nil)
                   }
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

