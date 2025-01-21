//
//  AIUserSettings.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 20.01.2025.
//

import SwiftUI

struct AIUserSettings: View {

    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(.accent)
            
            Text("Name Surname")
                .font(.system(.title3, design: .rounded, weight: .semibold))
                .lineLimit(1)
                .frame(maxWidth: UIConstants.screenWidth - 40)
                .foregroundStyle(.aiLabel)
            
            Text("email@example.com")
                .font(.system(.subheadline, design: .rounded, weight: .light))
                .lineLimit(1)
                .frame(maxWidth: UIConstants.screenWidth - 20)
                .foregroundStyle(.aiLabel)
        }
    }
}

#Preview {
    AIUserSettings()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
