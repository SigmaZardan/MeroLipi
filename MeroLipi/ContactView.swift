//
//  ContactView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 12/09/2025.
//

import SwiftUI

struct ContactView: View {
    @Environment(\.openURL) private var openUrl
    @State private var showError = false

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Need help or want to share feedback?")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button {
                    sendEmail()
                } label: {
                    Label("Send Email", systemImage: "envelope.fill")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(12)
                }
                .buttonStyle(.plain)
                .padding()
            }
        }
        .alert("Unable to send email.", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        }
        .navigationTitle("Contact Us")
    }

    func sendEmail() {
        let urlString = "mailto:bibekbhujel077@email.com?subject=Feedback&body=Hi%20there!"
        guard let url = URL(string: urlString) else { return }

        if UIApplication.shared.canOpenURL(url) {
            openUrl(url)
        } else {
            showError = true
        }
    }
}



#Preview {
    NavigationStack {
        ContactView()
    }
}
