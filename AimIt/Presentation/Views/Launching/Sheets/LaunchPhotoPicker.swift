//
//  LaunchPhotoPicker.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 22.01.2025.
//

import SwiftUI
import PhotosUI

struct LaunchPhotoPicker: View {
    
    @Binding private var selection: UIImage?
    @State private var selectedItem: PhotosPickerItem? = nil
    
    init(selection: Binding<UIImage?>) {
        self._selection = selection
    }
    
    var body: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images
        ) {
            Text("Pick a photo")
        }
        .onChange(of: selectedItem) { newValue in
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    withAnimation {
                        self.selection = image
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchPhotoPicker(selection: .constant(UIImage()))
}
