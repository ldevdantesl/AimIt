//
//  AIMilestoneView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import Foundation
import SwiftUI

struct AIMilestoneRow: View {
    @EnvironmentObject var milestoneVM: MilestoneViewModel
    @State var milestone: Milestone
    
    enum RowType {
        case toggling, removing
    }
    
    private let rowType: RowType
    private let onDelete: (() -> Void)
    private let onTap: (() -> Void)?
    
    init(milestone: Milestone) {
        self.milestone = milestone
        self.rowType = .toggling
        self.onDelete = {}
        self.onTap = nil
    }
    
    init(
        milestone: Milestone,
        rowType: RowType = .removing,
        onTap: (() -> Void)? = {},
        onDelete: @escaping (() -> Void)
    ){
        self.milestone = milestone
        self.rowType = rowType
        self.onDelete = onDelete
        self.onTap = onTap
    }
    
    var body: some View {
        HStack(spacing: 15){
            HStack{
                Image(systemName: milestone.systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text(milestone.desc)
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .foregroundStyle(milestone.isCompleted ? .aiLabel : .aiSecondary2)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(milestone.isCompleted ? .green : .aiSecondary, in: .rect(cornerRadius: 15))
            .onTapGesture(perform: onTap ?? {})
            
            if rowType == .toggling {
                Button{
                    milestone.isCompleted.toggle()
                    milestoneVM.toggleMilestoneCompletion(milestone)
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(milestone.isCompleted ? .green : .aiSecondary)
                        .frame(width: 50)
                        .overlay {
                            Image(systemName: milestone.isCompleted ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(milestone.isCompleted ? .aiLabel : .aiSecondary2)
                        }
                }
            } else {
                Button{
                    onDelete()
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.accent)
                        .frame(width: 50)
                        .overlay {
                            Image(systemName: "trash.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.aiLabel)
                        }
                }
            }
        }
        .animation(.bouncy, value: milestone)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .padding(.horizontal, 20)
    }
}

#Preview {
    AIMilestoneRow(milestone: Milestone.sample, rowType: .removing, onDelete: {})
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeMilestoneViewModel())
}
