//
//  AIUserSettings.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 20.01.2025.
//

import SwiftUI
import PhotosUI

struct AIUserSettings: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var coordinator: SettingsCoordinator
    
    var body: some View {
        Button(action: pushToEdit) {
            VStack{
                if let image = userVM.profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(userVM.themeColor)
                }
                
                Text(userVM.fullName)
                    .font(.system(.title3, design: .rounded, weight: .semibold))
                    .lineLimit(1)
                    .frame(maxWidth: UIConstants.screenWidth - 40)
                    .foregroundStyle(.aiLabel)
                    .contentTransition(.numericText())
            }
        }
    }
    
    private func pushToEdit() {
        coordinator.present(fullScreenCover: .editProfile)
    }
}

#Preview {
    AIUserSettings()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(UserViewModel())
}
