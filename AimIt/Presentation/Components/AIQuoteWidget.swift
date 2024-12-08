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
            HStack{
                Text("Quote: ")
                    .font(.system(.headline, design: .rounded, weight: .bold))
                    .foregroundStyle(.aiBlack)
                    .fontDesign(.serif)
                
                Spacer()
            }
            Text(quote)
                .foregroundStyle(.aiBlack)
                .font(.system(.subheadline, design: .rounded, weight: .regular))
            
            Spacer()
        }
        .padding([.top,.horizontal],20)
        .frame(maxWidth: (UIConstants.screenWidth / 2) - 20)
        .frame(maxHeight: UIConstants.screenHeight / 6)
        .background(Color.aiSecondBackground, in: .rect(cornerRadius: 30))
        .padding(.leading, 20)
    }
}

#Preview {
    AIQuoteWidget(
        quote: "Some quote")
}
