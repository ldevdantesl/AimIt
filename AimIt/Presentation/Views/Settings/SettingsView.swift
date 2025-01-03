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
                Text("Settings View")
                    .foregroundStyle(.aiLabel)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.aiBackground)
            .sheet(item: $coordinator.sheet) { sheet in
                coordinator.build(sheet: sheet)
            }
            .fullScreenCover(item: $coordinator.fullScreenCover) { screenCover in
                coordinator.build(screenCovers: screenCover)
            }
            .navigationDestination(for: SettingsScreens.self) { screen in
                coordinator.build(screen: screen)
            }
            .safeAreaInset(edge: .bottom) {
                FloatingTabBar()
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsCoordinator())
}
