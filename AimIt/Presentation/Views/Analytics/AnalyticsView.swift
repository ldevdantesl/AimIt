//
//  AnalyticsView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 2.01.2025.
//

import SwiftUI

struct AnalyticsView: View {
    @EnvironmentObject var coordinator: AnalyticsCoordinator
    var body: some View {
        NavigationStack(path: $coordinator.path){
            ScrollView{
                Text("Analytics View")
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
            .navigationDestination(for: AnalyticsScreens.self) { screen in
                coordinator.build(screen: screen)
            }
            .safeAreaInset(edge: .bottom) {
                FloatingTabBar()
            }
        }
    }
}

#Preview {
    AnalyticsView()
        .environmentObject(AnalyticsCoordinator())
}
