//
//  DIContainer.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation

final class DIContainer {
    
    let CDstack = CoreDataStack(modelName: "AimIt")
    
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
            updateMilestoneUseCase: UpdateMilestoneUseCaseImpl(repository: repository)
        )
    }
}
