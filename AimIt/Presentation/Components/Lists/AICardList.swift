//
//  AICardList.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AICardList: View {
    var goals: [Goal] = []
    
    var body: some View {
        LazyVStack(spacing: 20) {
            ForEach(goals, id: \.self) { goal in
                AICardView(goal: goal)
            }
        }
    }
}

#Preview {
    AICardList(goals: [])
}
