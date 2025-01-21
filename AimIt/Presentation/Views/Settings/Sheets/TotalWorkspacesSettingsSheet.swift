//
//  TotalWorkspacesSettingsSheet.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 21.01.2025.
//

import SwiftUI

struct TotalWorkspacesSettingsSheet: View {
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    
    @State private var isTrynaDelete: Bool = false
    @State private var toDeleteWorkspace: Workspace?
    
    var body: some View {
        VStack(spacing: 10) {
            AIInfoField(
                title: "Total Workspaces",
                info: "Workspaces",
                buttonSystemImage: "briefcase.fill",
                buttonSize: 30
            )
            
            VStack(spacing: 10){
                ForEach(workspaceVM.workspaces) { workspace in
                    HStack{
                        VStack(alignment: .leading) {
                            Text(workspace.title)
                                .font(.system(.headline, design: .rounded, weight: .semibold))
                                .foregroundStyle(Color.aiBlack)
                                .lineLimit(1)
                            
                            Text("Total \(workspace.goals.count.description) goal(s)")
                                .font(.system(.footnote, design: .rounded, weight: .light))
                                .foregroundStyle(Color.aiSecondary2)
                                .lineLimit(1)
                        }
                        
                        Spacer()
                        
                        if workspaceVM.workspaces.count > 1 {
                            Button(action: { delete(workspace) } ) {
                                Image(systemName: "trash.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.aiLabel)
                                    .padding(10)
                                    .background(Color.red, in: .rect(cornerRadius: 10))
                            }
                        }
                    }
                    .contentTransition(.numericText())
                    .padding(.all, 10)
                    .background(Color.aiBeige, in: .rect(cornerRadius: 15))
                    .padding(.horizontal, 20)
                }
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .confirmationDialog("Delete", isPresented: $isTrynaDelete) {
            Button("Delete", role: .destructive, action: actuallyDeleteWorkspace)
        } message: {
            Text("This action is permanent and cannot be undone.")
        }

    }
    
    private func delete(_ workspace: Workspace) {
        withAnimation {
            toDeleteWorkspace = workspace
            isTrynaDelete.toggle()
        }
    }
    
    private func actuallyDeleteWorkspace() {
        withAnimation {
            if let toDeleteWorkspace {
                if workspaceVM.currentWorkspace.id == toDeleteWorkspace.id {
                    if let newCurrentWorksapce = workspaceVM.workspaces.first(where: { $0.id != toDeleteWorkspace.id }) {
                        workspaceVM.currentWorkspace = newCurrentWorksapce
                    }
                }
                workspaceVM.deleteWorkspace(toDeleteWorkspace)
                self.toDeleteWorkspace = nil
            }
        }
    }
}

#Preview {
    TotalWorkspacesSettingsSheet()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeWorkspaceViewModel())
}
