//
//  IntroView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import SwiftUI

struct IntroView: View {
    @EnvironmentObject var coordinator: LaunchCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path){
            ScrollView {
                Image("Intro1")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 310)
                    .padding(.bottom, 25)
                
                AIInfoField(title: "", info: "Start Achieving your goals!", infoFontStyle: .title2)
            }
            .background(Color.aiBackground)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    AIButton(title: "Continue") {
                        coordinator.push(to: .addWorkspace)
                    }
                }
            }
            .navigationDestination(for: LaunchScreens.self) { screen in
                coordinator.build(screen: screen)
            }
        }
    }
}

#Preview {
    IntroView()
        .environmentObject(LaunchCoordinator(onFinish: {}))
}
