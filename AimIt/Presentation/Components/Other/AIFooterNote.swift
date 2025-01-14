//
//  AIFooter.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import SwiftUI

struct AIFooterNote: View {
    private let text: String
    private let condition: Bool
    
    init(
        text: String,
        condition: Bool = true
    ) {
        self.text = text
        self.condition = condition
    }
    
    var body: some View {
        if condition {
            Text("Note: \(text)")
                .font(.system(.caption, design: .rounded, weight: .regular))
                .foregroundStyle(.aiSecondary2)
        }
    }
}

#Preview {
    AIFooterNote(text: "If deadline is passed you won't be able to manipulate it unless you change the deadline")
}
