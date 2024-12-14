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
                        subtitle: "Buzurgmehr Rahimzoda"
                    )
                    
                    AISearchBar(
                        searchText: $searchText,
                        workspaceName: workspaceVM.currentWorkspace.title
                    )
                    .padding(.bottom, 5)
                    
                    AIWorkspaceSelector()
                    
                    HStack(alignment: .top){
                        AIGoalWidget(workspace: workspaceVM.currentWorkspace)
                        
                        Spacer()
                        
                        AIQuoteWidget(quote: "Well done is better than well said. - Napoleon Bonaparte")
                    }
                    
                    AIGoalCardList(goals: workspaceVM.currentWorkspace.goals)
                }
            }
            .background(UIConstants.backgroundColor)
            .animation(.bouncy, value: workspaceVM.currentWorkspace)
            .sheet(item: $coordinator.sheet) { sheet in
                coordinator.build(sheet: sheet)
            }
            .navigationDestination(for: HomeScreens.self) { screen in
                coordinator.build(screen: screen)
            }
            .onAppear {
                goalVM.fetchGoals()
                workspaceVM.fetchCurrentWorkspace()
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
