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
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    
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
                            action: { coordinator.push(to: .addGoal) }
                        ),
                        title: "Good morning 🌥️",
                        subtitle: "Buzurg Rahimzoda"
                    )
                    
                    AISearchBar(
                        searchText: $searchText,
                        workspaceName: workspaceVM.currentWorkspace?.title ?? "Workspaces"
                    )
                    
                    HStack(alignment: .top){
                        AIGoalWidget(goal: .sample)
                        
                        Spacer()
                        
                        AIQuoteWidget(quote: "Well done is better than well said. - Napoleon Bonaparte")
                    }
                }
            }
            .background(UIConstants.backgroundColor)
            .navigationDestination(for: HomeScreens.self) { screen in
                coordinator.build(screen: screen)
            }
            .onAppear{
                goalVM.fetchGoals()
            }
        }
    }
}

#Preview {
    NavigationStack{
        HomeView()
            .environmentObject(HomeCoordinator())
            .environmentObject(DIContainer().makeGoalViewModel())
            .environmentObject(DIContainer().makeWorkspaceViewModel())
    }
}
