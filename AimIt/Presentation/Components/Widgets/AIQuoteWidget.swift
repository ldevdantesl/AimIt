//
//  AIQuoteView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import SwiftUI

struct AIQuoteWidget: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    
    private let quoteVM: QuoteViewModel
    private let quote: Quote
    
    init(quoteVM: QuoteViewModel) {
        self.quoteVM = quoteVM
        self.quote = quoteVM.randomQuote
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(quote.author)
                .font(.system(.subheadline, design: .rounded, weight: .bold))
                .foregroundStyle(.aiLabel)
                .fontDesign(.serif)
            
            Text(quote.quote)
                .foregroundStyle(.aiLabel)
                .font(.system(.subheadline, design: .rounded, weight: .regular))
        }
        .padding(15)
        .frame(maxWidth: UIConstants.widgetWidth, alignment: .leading)
        .frame(maxHeight: UIConstants.widgetHeight, alignment: .top)
        .background(Color.aiOrange, in: .rect(cornerRadius: UIConstants.widgetCornerRadius))
        .padding(.trailing, 20)
        .onTapGesture {
            coordinator.present(sheet: .quote(quoteVM))
        }
    }
}

#Preview {
    AIQuoteWidget(
        quoteVM: DIContainer().makeQuoteViewModel()
    )
}
