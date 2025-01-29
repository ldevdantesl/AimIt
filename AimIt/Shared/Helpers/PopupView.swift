//
//  PopupView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 9.01.2025.
//

import SwiftUI

struct AIPopupView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: 300)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}
