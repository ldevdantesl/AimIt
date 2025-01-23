//
//  LaunchAddProfileView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 22.01.2025.
//

import SwiftUI
import PhotosUI

struct LaunchAddProfileView: View {
    @EnvironmentObject var coordinator: LaunchCoordinator
    
    @State private var fullName: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var errorMsg: String?
    
    var body: some View {
        VStack{
            AIHeaderView(title: "Craft unique Identity", subtitle: "Create Profile")
            
            Spacer()
                .frame(height: UIConstants.halfHeight / 3)
            
            VStack {
                Button(action: {}) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundStyle(.accent)
                }
                
                AITextField(titleName: "", placeholder: "John Doe", text: $fullName, errorMsg: $errorMsg)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton(title: "Continue")
            }
        }
    }
}

#Preview {
    NavigationStack{
        LaunchAddProfileView()
            .environmentObject(LaunchCoordinator(onFinish: {}))
    }
}
