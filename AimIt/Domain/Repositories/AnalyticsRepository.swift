//
//  AnalyticsRepository.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import Foundation

protocol AnalyticsRepository {
    
    // MARK: - GOALS
    
    /// Fetch total goals count in a workspace.
    func fetchTotalGoals(in workspace: Workspace) throws -> Int
    
    /// Fetch completed goals in a workspace.
    func fetchCompletedGoals(in workspace: Workspace) throws -> [Goal]
    
    /// Fetch uncompleted goals in a workspace.
    func fetchUncompletedGoals(in workspace: Workspace) throws -> [Goal]
    
    /// Fetch completed goals within month in a workspace.
    func fetchGoalsCompletedWithinMonth(in workspace: Workspace) throws -> [Goal]
    
    /// Fetch the average time taken to complete goals in a workspace.
    func averageGoalCompletionTime(in workspace: Workspace) throws -> TimeInterval
    
    // MARK: - MILESTONES
    
    /// Fetch total milestones count in a workspace.
    func fetchTotalMilestones(in workspace: Workspace) throws -> Int
    
    /// Fetch completed milestones for in a workspace.
    func fetchCompletedMilestones(in workspace: Workspace) throws -> [Milestone]
    
    /// Fetch uncompleted milestones in a workspace.
    func fetchUncompletedMilestones(in workspace: Workspace) throws -> [Milestone]
    
    /// Fetch completed milestones within last 7 days in a workspace.
    func fetchCompletedMilestonesWithinWeek(in workspace: Workspace) throws -> [Milestone]
    
    /// Fetch the average time taken to complete milestones in a workspace.
    func averageMilestoneCompletionTime(in workspace: Workspace) throws -> TimeInterval
}
