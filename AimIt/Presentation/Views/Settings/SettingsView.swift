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
                        .padding(.vertical, 20)
                    
                    AISettingsContent()
                    
                    Text("-Version \(Constants.APP_VERSION ?? "1.0.0")")
                        .font(.system(.caption2, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiSecondary2)
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.aiBackground)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    FloatingTabBar(action: showEditProfile)
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
    
    private func showEditProfile() {
        coordinator.present(fullScreenCover: .editProfile)
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsCoordinator())
        .environmentObject(TabCoordinator())
}
