//
//  HomeView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var tabCoordinator: TabCoordinator
    @EnvironmentObject var coordinator: HomeCoordinator
    @EnvironmentObject var goalVM: GoalViewModel
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    @EnvironmentObject var quoteVM: QuoteViewModel
    
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
                    
                    AIPrioritizedGoalCard(in: workspaceVM.currentWorkspace)
                    
                    HStack(alignment: .top) {
                        AIGoalWidget(workspace: workspaceVM.currentWorkspace)
                        
                        Spacer()
                        
                        
                        AIQuoteWidget(quote: quoteVM.randomQuote)
                            .onTapGesture {
                                coordinator.present(sheet: .quote(quoteVM))
                            }
                    }
                    
                    AIGoalCardList()
                }
            }
            .background(UIConstants.backgroundColor)
            .animation(.bouncy, value: workspaceVM.currentWorkspace)
            .sheet(item: $coordinator.sheet) { sheet in
                coordinator.build(sheet: sheet)
            }
            .fullScreenCover(item: $coordinator.fullScreenCover) { screen in
                coordinator.build(fullScreenCover: screen)
            }
            .navigationDestination(for: HomeScreens.self) { screen in
                coordinator.build(screen: screen)
            }
            .onAppear {
                goalVM.fetchGoals()
                workspaceVM.fetchCurrentWorkspace()
            }
            .safeAreaInset(edge: .bottom) {
                FloatingTabBar(action: { coordinator.push(to: .addGoal) })
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
            .environmentObject(DIContainer().makeQuoteViewModel())
    }
}
