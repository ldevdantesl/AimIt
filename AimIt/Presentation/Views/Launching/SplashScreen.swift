//
//  SplashScreen.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 12.12.2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var offset: CGFloat = 0
    @State private var isAnimating = false
    let onFinish: () -> ()
    var body: some View {
        VStack {
            Image(.splash)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .offset(y:100 - offset)
                .onAppear {
                    startBouncing()
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.aiBackground)
        .onAppear(perform: onFinish)
    }
    
    private func startBouncing() {
        withAnimation(
            Animation.interpolatingSpring(stiffness: 100, damping: 5)
        ) {
            offset = 100
        }
    }
}

#Preview {
    SplashScreen(onFinish: {})
}
