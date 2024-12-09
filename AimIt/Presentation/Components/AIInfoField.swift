//
//  AIInfoField.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import Foundation
import SwiftUI

struct AIInfoField: View {
    let title: String
    let info: String
    
    let infoFontStyle: Font.TextStyle
    let infoForeColor: Color
    
    init(
        title: String,
        info: String,
        infoFontStyle: Font.TextStyle = .title2,
        infoForeColor: Color = .aiLabel
    ) {
        self.title = title
        self.info = info
        self.infoFontStyle = infoFontStyle
        self.infoForeColor = infoForeColor
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(title)
                    .font(.system(.headline, design: .rounded, weight: .light))
                    .foregroundStyle(.aiSecondary2)
                
                Text("\(info)")
                    .font(.system(infoFontStyle, design: .rounded, weight: .semibold))
                    .foregroundStyle(infoForeColor)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AIInfoField(title: "Title", info: "Some info")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
