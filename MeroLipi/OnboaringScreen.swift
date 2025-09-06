//
//  OnboaringScreen.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 03/09/2025.
//

import SwiftUI

struct OnboardingScreen: View {
    @State private var selectedTab = 0
    @Binding var showingOnboardingScreen:Bool
    @FocusState private var isFieldFocused: Bool

    var indexDisplayMode:PageTabViewStyle.IndexDisplayMode {
        isFieldFocused ? .never : .automatic
    }

    var body: some View {
        TabView(selection: $selectedTab){
            FirstStepInstructionView(selectedTab: $selectedTab)
            .tag(0)

            SecondStepInstructionView(
                onFinishSetupClicked: {
                    showingOnboardingScreen = false
                },
                isFocused: $isFieldFocused)
                .tag(1)
        }
        .interactiveDismissDisabled()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: indexDisplayMode))
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .label
            UIPageControl.appearance().pageIndicatorTintColor = .systemGray
        }
    }
}

#Preview {
    OnboardingScreen(showingOnboardingScreen: .constant(false))
}
