//
//  GoalDetailsView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

struct GoalDetailsView: View {
    @State var goal: Goal = .sample
    
    var body: some View {
        VStack{
            
        }
        .navigationTitle("\(goal.title)")
    }
}

#Preview {
    NavigationStack{
        GoalDetailsView()
    }
}
