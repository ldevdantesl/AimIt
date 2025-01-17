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
                    
                    if searchText.isEmpty {
                        AIWorkspaceSelector()
                        
                        AIPrioritizedGoalCard(in: workspaceVM.currentWorkspace)
                        
                        HStack(alignment: .top) {
                            AIGoalWidget(workspace: workspaceVM.currentWorkspace)
                            
                            Spacer()
                            
                            AIQuoteWidget(quoteVM: quoteVM)
                        }
                        
                        AIGoalCardList(in: workspaceVM.currentWorkspace)
                        
                        AITodayMilestones(workspace: workspaceVM.currentWorkspace)
                    } else {
                        AISearchResultsView(searchText: $searchText, in: workspaceVM.currentWorkspace)
                    }
                }
                .padding(.bottom, 20)
            }
            .background(UIConstants.backgroundColor)
            .animation(.bouncy, value: workspaceVM.currentWorkspace)
            .animation(.bouncy, value: searchText)
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
                workspaceVM.fetchCurrentWorkspace()
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    FloatingTabBar(menuContent: menuContentTabBar)
                        .frame(maxWidth: .infinity)
                }
            }
            .toolbarBackground(.clear, for: .bottomBar)
        }
    }
    
    @ViewBuilder
    private func menuContentTabBar() -> some View {
        Text("Sort by")
        
        Button {
            withAnimation {
                workspaceVM.sortSystem = { $0.deadline < $1.deadline }
            }
        } label: { Label("Deadline", systemImage: "deskclock") }
        
        Button {
            withAnimation {
                workspaceVM.sortSystem = { $0.createdAt < $1.createdAt }
            }
        } label: { Label("Creation Date", systemImage: "calendar") }
        
        Button {
            withAnimation {
                workspaceVM.sortSystem = { ($0.milestones?.count ?? 0) > ($1.milestones?.count ?? 0) }
            }
        } label: { Label("Total Milestones", systemImage: "flag.2.crossed") }
        
        Button {
            withAnimation {
                workspaceVM.sortSystem = { $0.title < $1.title }
            }
        } label: { Label("Alphabetic", systemImage: "b.circle.fill") }
    }
}

#Preview {
    NavigationStack{
        HomeView()
            .environmentObject(HomeCoordinator())
            .environmentObject(DIContainer().makeGoalViewModel())
            .environmentObject(DIContainer().makeWorkspaceViewModel())
            .environmentObject(DIContainer().makeQuoteViewModel())
            .environmentObject(TabCoordinator())
    }
}
