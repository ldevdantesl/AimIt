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
                VStack(spacing: 30) {
                    AIHomeHeaderView()
                    AISearchBar(searchText: $searchText)
                    
                   
                }
            }
            .background(UIConstants.backgroundColor)
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
