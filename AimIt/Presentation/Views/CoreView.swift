//
//  CoreView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 2.01.2025.
//

import SwiftUI

struct CoreView: View {
    @EnvironmentObject var tabCoordinator: TabCoordinator
    @EnvironmentObject var userVM: UserViewModel
    
    @State private var tint: Color = .accentColor
    
    var body: some View {
        ZStack{
            switch tabCoordinator.selectedTab {
            case .home:
                tabCoordinator.homeCoordinator.start()
            case .analytics:
                tabCoordinator.analyticsCoordinator.start()
            case .settings:
                tabCoordinator.settingsCoordinator.start()
            }
        }
        .transition(.push(from: .trailing))
        .animation(.easeInOut, value: tabCoordinator.selectedTab)
    }
}

#Preview {
    CoreView()
        .environmentObject(TabCoordinator())
}
