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
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ScrollView{
                VStack(spacing: 20) {
                    AIHeaderView(
                        leftButton: AIButton(image: .back),
                        rightButton: AIButton(
                            image: .plus,
                            action: { coordinator.navigateTo(screen: .addGoal) }
                        ),
                        title: "Good morning 🌥️",
                        subtitle: "Buzurg Rahimzoda"
                    )
                    AISearchBar(searchText: $searchText)
                    
                    VStack(spacing: 20){
                        AICardView(goal: Goal.sample)
                        AICardView(goal: Goal.sample)
                    }
                }
                .padding(.top, 10)
            }
            .background(UIConstants.backgroundColor)
            .setDestinationsForHomeScreen()
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
