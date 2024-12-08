//
//  GoalRepository.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation

protocol GoalRepository {
    
    func addGoal(
        title: String,
        desc: String?,
        deadline: Date?,
        milestones: [Milestone]
    ) throws
    
    func editGoal(
        _ goal: Goal,
        newTitle: String?,
        newDesc: String?,
        newDeadline: Date?
    ) throws
    
    func completeGoal(_ goal: Goal) throws
    
    func uncompleteGoal(_ goal: Goal) throws
    
    func deleteGoal(_ goal: Goal) throws
    
    func fetchGoals() throws -> [Goal]
}
