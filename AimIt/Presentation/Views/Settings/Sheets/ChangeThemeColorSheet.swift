//
//  ChangeThemeColorSheet.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 23.01.2025.
//

import SwiftUI

struct ChangeThemeColorSheet: View {
    @EnvironmentObject var userVM: UserViewModel
    
    private let colorThemes: [Color] = UIConstants.themeColors
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(colorThemes, id: \.self) { color in
                    colorButton(color)
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    func colorButton(_ color: Color) -> some View {
        Button {
            withAnimation {
                userVM.updateThemeColor(color)
            }
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .frame(width: 80, height: 80)
                .overlay {
                    if color.toHexString() == userVM.themeColor.toHexString() {
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.aiLabel)
                    }
                }
        }
    }
}

#Preview {
    ChangeThemeColorSheet()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(UserViewModel())
}
