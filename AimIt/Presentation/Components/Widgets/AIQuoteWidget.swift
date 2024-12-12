//
//  AIQuoteView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import SwiftUI

struct AIQuoteWidget: View {
    let quote: String
    
    init(quote: String) {
        self.quote = quote
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("Quote: ")
                .font(.system(.headline, design: .rounded, weight: .bold))
                .foregroundStyle(.aiLabel)
                .fontDesign(.serif)
            
            Text(quote)
                .foregroundStyle(.aiLabel)
                .font(.system(.subheadline, design: .rounded, weight: .regular))
        }
        .padding(15)
        .frame(maxWidth: UIConstants.widgetWidth, alignment: .leading)
        .frame(maxHeight: UIConstants.widgetHeight, alignment: .top)
        .background(Color.aiOrange, in: .rect(cornerRadius: UIConstants.widgetCornerRadius))
        .padding(.trailing, 20)
    }
}

#Preview {
    AIQuoteWidget(
        quote: "Some quote")
}
