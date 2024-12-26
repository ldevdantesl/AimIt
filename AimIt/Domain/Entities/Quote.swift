//
//  Quote.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 26.12.2024.
//

import Foundation

struct Quote: Codable, Hashable, Identifiable {
    let id: Int
    let quote: String
    let author: String
}

extension Quote {
    static let sample = Quote(id: 0, quote: "In the middle of every difficulty lies opportunity.", author: "Albert Einstein")
}
