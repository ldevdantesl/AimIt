//
//  QuoteViewModel.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 26.12.2024.
//

import Foundation
import SwiftUI

final class QuoteViewModel: ObservableObject {
    @Published var quotes: [Quote] = []
    @Published var randomQuote: Quote = Quote.sample
    
    init() {
        fetchQuotes()
        randomizeQuote()
    }
    
    private func fetchQuotes() {
        let quotes: [Quote] = Bundle.main.decode("Quotes.json")
        self.quotes = quotes
    }
    
    public func randomizeQuote() {
        self.randomQuote = quotes.randomElement() ?? Quote.sample
    }
}
