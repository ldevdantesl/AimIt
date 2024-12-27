//
//  AIQuoteSheet.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 26.12.2024.
//

import SwiftUI

struct AIQuoteSheet: View {
    @State var quoteVM: QuoteViewModel

    init(quoteVM: QuoteViewModel) {
        self.quoteVM = quoteVM
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            AIInfoField(
                title: "Quote",
                titleFontStyle: .headline,
                titleForeColor: .ailIghtPink,
                info: quoteVM.randomQuote.author,
                infoForeColor: .aiLabel,
                infoFontDesign: .serif, 
                buttonSystemImage: "arrow.triangle.2.circlepath.circle.fill",
                buttonColor: .aiBeige,
                buttonSize: 25,
                buttonAction: quoteVM.randomizeQuote
            )
            Text("-- " + quoteVM.randomQuote.quote)
                .font(.system(.headline, design: .rounded, weight: .semibold))
                .foregroundStyle(.aiLabel)
                .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiOrange)
    }
}

#Preview {
    AIQuoteSheet(quoteVM: DIContainer().makeQuoteViewModel())
}
