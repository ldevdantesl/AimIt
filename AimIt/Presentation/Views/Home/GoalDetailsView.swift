//
//  GoalDetailsView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

struct GoalDetailsView: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    @EnvironmentObject var goalVM: GoalViewModel
    
    @State var goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    var body: some View {
        ScrollView{
            AIHeaderView(
                leftButton: AIButton(
                    image: .back,
                    action: coordinator.goBack
                ),
                rightButton: AIButton(
                    image: .edit,
                    backColor: .accentColor,
                    foreColor: .aiLabel
                ),
                title: "Goal",
                subtitle: "\(goal.title)"
            )
            
            Spacer(minLength: 30)
            
            AIInfoField(title: "Title", info: goal.title)
            
            Spacer(minLength: 30)
            
            if let description = goal.desc, !description.isEmpty {
                AIInfoField(
                    title: "Description",
                    info: description,
                    infoFontStyle: .headline,
                    infoForeColor: .aiSecondary2
                )
                Spacer(minLength: 30)
            }
            
            
            if let deadline = goal.deadline {
                AIInfoField(
                    title: "Deadline",
                    info: DeadlineFormatter.formatToDayMonth(date: deadline)
                )
                Spacer(minLength: 30)
            }
            
            LazyVStack(spacing: 20){
                HStack{
                    Text("Milestones")
                        .font(.system(.headline, design: .rounded, weight: .light))
                        .foregroundStyle(.aiSecondary2)
                        
                    Spacer()
                    
                    Image(systemName: "line.3.horizontal.decrease")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.aiLabel)
                }
                .padding(.horizontal, 20)
                ForEach(goal.milestones) { milestone in
                    AIMilestonesCardView(milestone: milestone)
                }
            }
        }
        .background(Color.aiBackground)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .bottomBar) {
                AIButton(title: goal.isCompleted ? "Uncomplete" : "Complete") {
                    goal.isCompleted ? goalVM.uncompleteGoal(goal) : goalVM.completeGoal(goal)
                    goal.isCompleted.toggle()
                }
            }
        }
        .onDisappear {
            goalVM.fetchGoals()
        }
    }
}

#Preview {
    NavigationStack{
        GoalDetailsView(goal: .sample)
            .background(Color.aiBackground)
            .environmentObject(DIContainer().makeAppCoordinator().makeHomeCoordinator())
            .environmentObject(DIContainer().makeGoalViewModel())
    }
}
