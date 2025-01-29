//
//  AISettingsRow.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 20.01.2025.
//

import SwiftUI

struct AISettingsRow: View {
    
    @EnvironmentObject var userVM: UserViewModel
    
    enum SettingsRowType {
        case toggle
        case pusher
        case button
    }
    
    enum SettingsRowImageBackgroundShape {
        case circular
        case roundRect
        
        func shape() -> some Shape {
            switch self {
            case .circular: RoundedRectangle(cornerRadius: 25)
            case .roundRect: RoundedRectangle(cornerRadius: 10)
            }
        }
    }
    
    private let image: String
    private let title: String
    private let imageBackgroundShape: SettingsRowImageBackgroundShape
    private let imageSize: CGFloat
    private let type: SettingsRowType
    private let textOnPusher: String?
    private let action: (() -> ())?
    
    @Binding private var isOn: Bool
    
    /// Settings Row for *Pusher* type to push to another screen or presenting something
    init(
        title: String,
        image: String,
        imageBackgroundShape: SettingsRowImageBackgroundShape = .circular,
        imageSize: CGFloat = 25,
        textOnPusher: String? = nil,
        pushAction: (() -> ())?
    ) {
        self.title = title
        self.image = image
        self.imageBackgroundShape = imageBackgroundShape
        self.imageSize = imageSize
        self.textOnPusher = textOnPusher
        self.action = pushAction
        self.type = .pusher
        self._isOn = .constant(false)
    }
    
    /// Settings Row for *Toggle* type to toggle some property
    init(
        title: String,
        image: String,
        imageSize: CGFloat = 25,
        imageBackgroundShape: SettingsRowImageBackgroundShape = .circular,
        isOn: Binding<Bool>
    ) {
        self.title = title
        self.image = image
        self.imageBackgroundShape = imageBackgroundShape
        self.imageSize = imageSize
        self._isOn = isOn
        self.type = .toggle
        self.action = nil
        self.textOnPusher = nil
    }
    
    /// Settings Row for *Button* type to call an action once its tapped
    init(
        title: String,
        image: String,
        imageBackgroundShape: SettingsRowImageBackgroundShape = .circular,
        imageSize: CGFloat = 25,
        textOnPusher: String? = nil,
        buttonAction: (() -> ())?
    ) {
        self.title = title
        self.image = image
        self.imageBackgroundShape = imageBackgroundShape
        self.imageSize = imageSize
        self._isOn = .constant(false)
        self.type = .button
        self.action = buttonAction
        self.textOnPusher = textOnPusher
    }
    
    var body: some View {
        Button(action: makeAction){
            HStack(spacing: 10) {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize, height: imageSize)
                    .padding(10)
                    .background(Color.aiSecondary, in: imageBackgroundShape.shape())
                    .foregroundStyle(.aiBeige)
                
                Text(title)
                    .font(.system(.headline, design: .rounded, weight: .bold))
                    .foregroundStyle(.aiLabel)
                
                Spacer()
                
                if let textOnPusher {
                    Text(textOnPusher)
                        .font(.system(.subheadline, design: .rounded, weight: .light))
                        .foregroundStyle(.aiSecondary2)
                }
                
                if type == .pusher {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.aiSecondary2)
                } else if type == .toggle {
                    Toggle(isOn: $isOn, label: {})
                        .tint(userVM.themeColor)
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
        }
    }
    
    private func makeAction() {
        type == .pusher || type == .button ? action?() : isOn.toggle()
    }
}
#Preview {
    AISettingsRow(title: "Favorites", image: "plus", isOn: .constant(true))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
