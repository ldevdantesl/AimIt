//
//  AIWorkspaceSelector.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 13.12.2024.
//

import SwiftUI

struct AIWorkspaceSelector: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    @EnvironmentObject var coordinator: HomeCoordinator
    
    @State private var isSelecting: Bool = false
    
    var body: some View {
        VStack(spacing: 10){
            
            AIInfoField(
                title: "Current workspace",
                info: workspaceVM.currentWorkspace.title,
                infoFontStyle: .title2,
                buttonSystemImage: isSelecting ? "chevron.up" : "chevron.down",
                buttonColor: .aiSecondary2,
                buttonSize: 15,
                buttonAction: { isSelecting.toggle() }
            )
            .animation(.bouncy, value: isSelecting)
            .contentTransition(.numericText())
            
            if isSelecting {
                VStack(spacing: 20){
                    ForEach(workspaceVM.workspaces, id: \.self) { workspace in
                        if workspace.title != workspaceVM.currentWorkspace.title {
                            Button {
                                workspaceVM.currentWorkspace = workspace
                                isSelecting.toggle()
                                workspaceVM.fetchCurrentWorkspace()
                            } label: {
                                HStack{
                                    AIInfoField(
                                        title: "\(workspace.goals.count) goals",
                                        info: workspace.title,
                                        infoFontStyle: .headline,
                                        infoForeColor: userVM.themeColor
                                    )
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 15, height: 15)
                                        .foregroundStyle(.aiSecondary2)
                                        .padding(.horizontal, 20)
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .trailing){
                        Button(action: createNewWorkspace) {
                            Text("+ New Workspace")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.system(.headline, design: .rounded, weight: .semibold))
                                .padding(.horizontal, 20)
                                .foregroundStyle(workspaceVM.workspaces.count > 2 ? .secondary : userVM.themeColor)
                        }
                        .disabled(workspaceVM.workspaces.count > 2)
                        
                        AIFooterNote(text: "Maximum amount is 3", condition: workspaceVM.workspaces.count > 2)
                            .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
    
    private func createNewWorkspace() {
        coordinator.present(sheet: .addWorkspace)
        isSelecting.toggle()
    }
}

#Preview {
    AIWorkspaceSelector()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeWorkspaceViewModel())
        .environmentObject(HomeCoordinator())
}
