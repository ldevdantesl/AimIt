//
//  AIButton.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import SwiftUI

struct AIButton: View {
    
    enum ImageType: String {
        case back
        case ellipsis
        case bell
        case plus
    }
    
    let title: String?
    let image: ImageType
    let action: (() -> ())?
    
    init(title: String? = nil, image: ImageType, action: (() -> ())? = nil) {
        self.title = title
        self.image = image
        self.action = action
    }
    
    var body: some View {
        Button{
            action?()
        } label: {
            ZStack {
                Circle()
                    .fill(.aiLabel.opacity(0.4))
                    .frame(width: 52, height: 52)
                    .zIndex(1)
                
                Circle()
                    .fill(.aiSecondBackground)
                    .frame(width: 45, height: 45)
                    .zIndex(2)
                
                makeImage()
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 20)
                    .zIndex(2)
                    .foregroundStyle(.aiBlack)
            }
            .frame(width: 45, height: 45)
        }
    }
    
    
    func makeImage() -> Image {
        switch image {
        case .back:
            return Image(systemName: "chevron.left")
        case .ellipsis:
            return Image(systemName: "ellipsis")
        case .bell:
            return Image(systemName: "bell")
        case .plus:
            return Image(systemName: "plus")
        }
    }
}

#Preview {
    AIButton(title: "Back", image: .back, action: nil)
}
