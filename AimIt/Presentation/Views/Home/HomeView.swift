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
                        leftButton: AIButton (image: .ava),
                        rightButton: AIButton (
                            image: .plus,
                            backColor: .accentColor,
                            foreColor: .aiLabel,
                            action: { coordinator.navigateTo(screen: .addGoal) }
                        ),
                        title: "Good morning 🌥️",
                        subtitle: "Buzurg Rahimzoda"
                    )
                    
                    AISearchBar(searchText: $searchText)
                    
                    AITimelineView()
                    
                    HStack{
                        AIQuoteWidget(quote: "Well done is better than well said")
                        
                        Spacer()
                    }
                    AICardList(goals: goalVM.goals)
                }
            }
            .background(UIConstants.backgroundColor)
            .setDestinationsForHomeScreen()
            .onAppear{
                goalVM.fetchGoals()
            }
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
