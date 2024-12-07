//
//  HomeScreens.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation

enum HomeScreens: Hashable {
    case goalDetails(Goal)
    case goalMilestones(Milestone)
    case addGoal
    case editGoal(Goal)
}
