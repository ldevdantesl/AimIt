//
//  AISettingsShareButton.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 24.01.2025.
//

import Foundation
import SwiftUI

struct AISettingsShareButton: View {
    private let URLString: String
    private let subject: String
    private let message: String?
    
    init(URLString: String, subject: String, message: String? = nil) {
        self.URLString = URLString
        self.subject = subject
        self.message = message
    }
    
    var body: some View {
        ShareLink(
            item: URL(string: URLString) ?? URL(string: "https://google.com")!,
            subject: Text(subject),
            message: Text(message ?? "")
        ) {
            HStack(spacing: 10) {
                Image(systemName: "arrowshape.turn.up.right.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .padding(10)
                    .background(Color.aiSecondary, in: .rect(cornerRadius: 10))
                    .foregroundStyle(.aiBeige)
                
                Text("Share")
                    .font(.system(.headline, design: .rounded, weight: .bold))
                    .foregroundStyle(.aiLabel)
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    AISettingsShareButton(URLString:"you want some" , subject: "Checkout the app", message: "Checkout the app")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
