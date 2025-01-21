//
//  SettingsView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var coordinator: SettingsCoordinator
    var body: some View {
        NavigationStack(path: $coordinator.path){
            ScrollView{
                VStack(spacing: 10){
                    AIHeaderView(
                        title: "Personalize Your Experience",
                        subtitle: "Settings",
                        swappedTitleAndSubtitle: true
                    )
                    
                    AIUserSettings()
                    
                    AISettingsContent()
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.aiBackground)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    FloatingTabBar()
                }
            }
            .toolbarBackground(.clear, for: .bottomBar)
            .sheet(item: $coordinator.sheet) { sheet in
                coordinator.build(sheet: sheet)
            }
            .fullScreenCover(item: $coordinator.fullScreenCover) { screenCover in
                coordinator.build(screenCovers: screenCover)
            }
            .navigationDestination(for: SettingsScreens.self) { screen in
                coordinator.build(screen: screen)
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsCoordinator())
        .environmentObject(TabCoordinator())
}
