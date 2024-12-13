//
//  WorkspaceViewModel.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation
import Combine

final class WorkspaceViewModel: ObservableObject {
    @Published var currentWorkspace: Workspace?
    
    @Published var workspaces: [Workspace] = []
    @Published var errorMsg: String?
    
    private let addWorkspaceUseCase: AddWorkspaceUseCase
    private let fetchWorkspacesUseCase: FetchWorkspacesUseCase
    private let editWorkspaceUseCase: EditWorkspaceUseCase
    private let deleteWorkspaceUseCase: DeleteWorkspaceUseCase
    
    init(
        addWorkspaceUseCase: AddWorkspaceUseCase,
        fetchWorkspacesUseCase: FetchWorkspacesUseCase,
        editWorkspaceUseCase: EditWorkspaceUseCase,
        deleteWorkspaceUseCase: DeleteWorkspaceUseCase
    ) {
        self.addWorkspaceUseCase = addWorkspaceUseCase
        self.fetchWorkspacesUseCase = fetchWorkspacesUseCase
        self.editWorkspaceUseCase = editWorkspaceUseCase
        self.deleteWorkspaceUseCase = deleteWorkspaceUseCase
    }
    
    func addWorkspace(title: String, goals: [Goal] = []){
        do {
            try addWorkspaceUseCase.execute(title: title, goals: goals)
        } catch {
            errorMsg = "Error creating workspace: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func fetchWorkspaces(){
        do {
            self.workspaces = try fetchWorkspacesUseCase.execute()
        } catch {
            errorMsg = "Error fetching workspaces: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func editWorkspace(_ workspace: Workspace, newTitle: String, newGoals: [Goal]) {
        do {
            try editWorkspaceUseCase.execute(workspace, newTitle: newTitle, newGoals: newGoals)
        } catch {
            errorMsg = "Error editing workspace: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func deleteWorkspace(_ workspace: Workspace) {
        do {
            try deleteWorkspaceUseCase.execute(workspace)
        } catch {
            errorMsg = "Error deleting workspace: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
}
