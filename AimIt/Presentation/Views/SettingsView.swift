//
//  SettingsView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        Text("Settings")
    }
}

#Preview {
    SettingsView()
        .environmentObject(DIContainer().makeAppCoordinator())
}
