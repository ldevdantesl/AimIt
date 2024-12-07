//
//  HomeView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    @EnvironmentObject var goalVM: GoalViewModel
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            List{
                ForEach(goalVM.goals, id: \.self) { goal in
                    Button("\(goal.title)") {
                        coordinator.navigateTo(screen: .goalDetails(goal))
                    }
                }
            }
            .navigationTitle("Goals: \(goalVM.goals.count)")
            .setDestinationForGoal()
        }
    }
}

#Preview {
    NavigationStack{
        HomeView()
            .environmentObject(DIContainer().makeAppCoordinator().makeHomeCoordinator())
            .environmentObject(DIContainer().makeGoalViewModel())
    }
}
