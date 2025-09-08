//
//  SecondStepInstructionView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 03/09/2025.
//

import SwiftUI
struct SecondStepInstructionView: View {

    @State private var text: String = ""
    let onFinishSetupClicked: () -> Void
    var isFocused: FocusState<Bool>.Binding
    @Namespace var  bottomID

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            ScrollViewReader { proxy in
                ScrollView {
                    VStack {
                        OnboardingStepHeaderView(stepNumber: 2)
                        Spacer()

                        InstructionView(iconName: "globe", instruction: "Tap and hold Globe icon", instructionPortionToBold: "Globe")
                        InstructionView(instruction: "Tap MeroLipiKeyboard to switch keyboards", instructionPortionToBold: "MeroLipiKeyboard")
                        InstructionView(iconName: "keyboard",instruction: "Try typing in Nepali", instructionPortionToBold: "Nepali")
                        TextField("Type here", text: $text)
                            .font(.title3)
                            .padding()
                            .background(Color.indigo.opacity(0.2), in: Capsule())
                            .disableAutocorrection(true)
                            .padding()
                            .focused(isFocused)
                            .onChange(of: isFocused.wrappedValue) { _ , newValue in
                                if newValue {

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            proxy.scrollTo(bottomID, anchor: .bottom)
                                        }
                                    }
                                }
                            }


                        SetupButton(
                            buttonTitle: "Finish Setup",
                            onClick: onFinishSetupClicked
                        )
                        .id(bottomID)
                    }
                }
            }
        }
    }
}
#Preview {
    @FocusState var isFieldFocused: Bool
    SecondStepInstructionView(onFinishSetupClicked: {}, isFocused:$isFieldFocused )
}
