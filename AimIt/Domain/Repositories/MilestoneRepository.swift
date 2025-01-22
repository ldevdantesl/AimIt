//
//  MilestoneRepository.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation

protocol MilestoneRepository {
    
    func addMilestone(
        desc: String,
        systemImage: String,
        dueDate: Date?,
        completed: Bool,
        to goal: Goal
    ) throws
    
    func updateMilestone(
        _ milestone: Milestone,
        desc: String?,
        systemImage: String?,
        dueDate: Date?
    ) throws
    
    func deleteMilestone(_ milestone: Milestone) throws
    
    func fetchMilestones(for goal: Goal) throws -> [Milestone]
    
    func fetchAllMilestones() throws -> [Milestone]
    
    func fetchTodayMilestonesForWorkspace(for workspace: Workspace, date: Date) throws -> [Milestone]
    
    func fetchMilestonesByPrompt(with prompt: String, in workspace: Workspace) throws -> [Milestone]
    
    func fetchCompletedMilestoneForWorkspace(_ workspace: Workspace) throws -> [Milestone]
    
    func toggleMilestoneCompletion(_ milestone: Milestone) throws
    
    func createSeparateMilestone(desc: String, systemImage: String, dueDate: Date?, completed: Bool) throws -> Milestone
}
