//
//  EditProfileScreenCover.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 23.01.2025.
//

import SwiftUI
import PhotosUI

struct EditProfileScreenCover: View {
    @EnvironmentObject var coordinator: SettingsCoordinator
    @EnvironmentObject var userVM: UserViewModel
    
    @State private var fullName: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var errorMsg: String? = "" 
    
    var body: some View {
        VStack{
            AIHeaderView(
                rightButton: AIButton(image: .xmark, action: dismiss),
                title: "Update your details",
                subtitle: "Edit Profile"
            )
            
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
                
                AITextField(titleName: "", placeholder: "John Doe", text: $fullName, errorMsg: $errorMsg)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton(
                    title: "Save",
                    color: errorMsg != nil ? .secondary : userVM.themeColor,
                    action: save
                )
                .disabled(errorMsg != nil)
            }
        }
        .onAppear(perform: setup)
    }
    
    private func dismiss() {
        coordinator.dismissFullScreenCover()
    }
    
    private func setup() {
        userVM.checkPhotoLibraryPermission()
        
        if userVM.photoLibraryStatus == .notDetermined {
            Task {
                await userVM.requestPhotoLibraryPermission()
            }
        }
        
        withAnimation {
            self.fullName = userVM.fullName
            self.selectedImage = userVM.profileImage
        }
    }
    
    private func save() {
        userVM.updateName(fullName)
        if let image = selectedImage {
            userVM.updateProfileImage(image)
        }
        dismiss()
    }
}

#Preview {
    NavigationStack{
        EditProfileScreenCover()
            .environmentObject(LaunchCoordinator(onFinish: {}))
    }
}
