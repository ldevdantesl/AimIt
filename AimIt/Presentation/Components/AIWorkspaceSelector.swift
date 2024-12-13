//
//  AIWorkspaceSelector.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 13.12.2024.
//

import SwiftUI

struct AIWorkspaceSelector: View {
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    
    @State private var isSelecting: Bool = false
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                VStack(alignment: .leading){
                    Text("Current workspace")
                        .font(.system(.caption, design: .rounded, weight: .light))
                        .foregroundStyle(.aiSecondary2)
                    
                    Text(workspaceVM.currentWorkspace?.title ?? "Workspace")
                        .font(.system(.title2, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiLabel)
                }
                Spacer()
                
                Button(action: { isSelecting.toggle() }){
                    Image(systemName: isSelecting ? "xmark" : "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 20)
                        .foregroundStyle(.aiSecondary2)
                }
            }
            .animation(.easeIn, value: isSelecting)
            
            if isSelecting {
                if workspaceVM.workspaces.count > 1 {
                    ForEach(workspaceVM.workspaces, id: \.self) { workspace in
                        Button {
                            workspaceVM.setCurrentWorkspace(workspace)
                        } label: {
                            Text(workspace.title)
                        }
                    }
                } else {
                    Text("No other workspaces")
                        .font(.system(.headline, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiSecondary2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AIWorkspaceSelector()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeWorkspaceViewModel())
}
