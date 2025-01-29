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
    @EnvironmentObject var userVM: UserViewModel
    
    @State private var fullName: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var errorMsg: String? = ""
    
    var body: some View {
        VStack{
            AIHeaderView(title: "Craft unique Identity", subtitle: "Create Profile")
            
            Spacer()
                .frame(height: UIConstants.halfHeight / 3)
            
            VStack {
                PhotosPicker(selection: $selectedItem, matching: .images){
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundStyle(userVM.themeColor)
                    }
                }
                .onChange(of: selectedItem) { _ in
                    Task {
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            await MainActor.run {
                                self.selectedImage = image
                            }
                        }
                    }
                }
                
                AITextField(
                    titleName: "",
                    placeholder: "John Doe",
                    text: $fullName,
                    errorMsg: $errorMsg
                )
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton(
                    title: "Continue",
                    color: errorMsg != nil ? .secondary : userVM.themeColor,
                    action: pushToWorkspace
                )
                .disabled(errorMsg != nil)
            }
        }
        .onAppear(perform: setup)
    }
    
    private func pushToWorkspace() {
        coordinator.push(to: .addWorkspace)
        userVM.updateName(fullName)
        if let image = selectedImage {
            userVM.updateProfileImage(image)
        }
    }
    
    private func setup() {
        Task{
            await userVM.requestNotificationPermission()
        }
    }
}

#Preview {
    NavigationStack{
        LaunchAddProfileView()
            .environmentObject(LaunchCoordinator(onFinish: {}))
    }
}
