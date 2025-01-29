//
//  AIQuoteView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import SwiftUI

struct AIQuoteWidget: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var coordinator: HomeCoordinator
    
    private let quoteVM: QuoteViewModel
    private let quote: Quote
    
    init(quoteVM: QuoteViewModel) {
        self.quoteVM = quoteVM
        self.quote = quoteVM.randomQuote
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack{
                Text(quote.author)
                    .font(.system(.subheadline, design: .serif, weight: .bold))
                    .foregroundStyle(.aiLabel)
                
                Spacer()
                
                Text("Quote")
                    .font(.system(.caption2, design: .serif, weight: .light))
                    .foregroundStyle(.aiBeige)
            }
            Text(quote.quote)
                .foregroundStyle(.aiLabel)
                .font(.system(.subheadline, design: .rounded, weight: .regular))
        }
        .padding(15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(maxHeight: UIConstants.widgetHeight)
        .background(userVM.themeColor.gradient, in: .rect(cornerRadius: UIConstants.widgetCornerRadius))
        .padding(.horizontal, 20)
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
