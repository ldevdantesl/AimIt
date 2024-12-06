//
//  MilestoneRepository.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation

protocol MilestoneRepository {
    func addMilestone(desc: String, to goal: Goal) throws
    func updateMilestone(_ milestone: Milestone, desc: String) throws
    func deleteMilestone(_ milestone: Milestone) throws
    func fetchMilestones(for goal: Goal) throws -> [Milestone]
    func fetchAllMilestones() throws -> [Milestone]
    func toggleMilestoneCompletion(_ milestone: Milestone) throws
}
