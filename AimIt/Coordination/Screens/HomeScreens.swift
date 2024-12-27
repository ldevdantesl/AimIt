//
//  HomeScreens.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation

enum HomeScreens: Hashable {
    case goalDetails
    case goalMilestones(Milestone)
    case addGoal
    case addMilestoneToGoal(Goal)
    case editGoal(Goal)
}
