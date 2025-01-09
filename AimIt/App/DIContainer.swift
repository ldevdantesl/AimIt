//
//  DIContainer.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation
import SwiftUI

@MainActor
final class DIContainer: ObservableObject {
    
    private let CDstack = CoreDataStack(modelName: Constants.COREDATA_MODEL)
    
    func makeWorkspaceViewModel() -> WorkspaceViewModel {
        let repository: WorkspaceRepository = WorkspaceRepositoryImpl(CDStack: CDstack)
        
        return WorkspaceViewModel(
            addWorkspaceUseCase: AddWorkspaceUseCaseImpl(repository: repository),
            fetchWorkspacesUseCase: FetchWorkspacesUseCaseImpl(repository: repository),
            fetchCurrentWorkspaceUseCase: FetchCurrentWorkspaceUseCaseImpl(repository: repository),
            editWorkspaceUseCase: EditWorkspaceUseCaseImpl(repository: repository),
            deleteWorkspaceUseCase: DeleteWorkspaceUseCaseImpl(repository: repository),
            prioritizeGoalUseCase: PrioritizeGoalUseCaseImpl(repository: repository),
            unprioritizeGoalUseCase: UnprioritizeGoalUseCaseImpl(repository: repository)
        )
    }
    
    func makeGoalViewModel() -> GoalViewModel {
        let repository: GoalRepository = GoalRepositoryImpl(CDstack: CDstack)
        
        return GoalViewModel(
            addGoalUseCase: AddGoalUseCaseImpl(repository: repository),
            deleteGoalUseCase: DeleteGoalUseCaseImpl(repository: repository),
            editGoalUseCase: EditGoalUseCaseImpl(repository: repository),
            fetchGoalsUseCase: FetchGoalsUseCaseImpl(repository: repository),
            toggleCompletionGoalUseCase: ToggleCompletionGoalUseCaseImpl(repository: repository)
        )
    }
    
    func makeMilestoneViewModel() -> MilestoneViewModel {
        let repository: MilestoneRepository = MilestoneRepositoryImpl(CDstack: CDstack)
        
        return MilestoneViewModel(
            addMilestoneUseCase: AddMilestoneUseCaseImpl(repository: repository),
            deleteMilestoneUseCase: DeleteMilestoneUseCaseImpl(repository: repository),
            fetchAllMilestonesUseCase: FetchAllMilestonesUseCaseImpl(repository: repository),
            fetchMilestonesForGoalUseCase: FetchMilestonesForGoalUseCaseImpl(repository: repository),
            toggleMilestoneCompletionUseCase: ToggleMilestoneCompletionUseCaseImpl(repository: repository),
            updateMilestoneUseCase: UpdateMilestoneUseCaseImpl(repository: repository),
            createSeperateMilestoneUseCase: CreateSeparateMilestoneUseCaseImpl(repository: repository)
        )
    }
    
    func makeQuoteViewModel() -> QuoteViewModel {
        return QuoteViewModel()
    }
}
