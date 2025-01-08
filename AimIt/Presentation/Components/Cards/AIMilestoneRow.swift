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
    private let onDelete: ((Milestone) -> Void)?
    private let onTap: ((Milestone) -> Void)?
    
    ///Initializer for removing. Used in a *AIMilestoneCreationList*
    ///Use when removing is option
    init(
        milestone: Milestone,
        onTap: ((Milestone) -> Void)? = nil,
        onDelete: ((Milestone) -> Void)? = nil
    ){
        self.milestone = milestone
        self.rowType = .removing
        self.onDelete = onDelete
        self.onTap = onTap
    }
    
    ///Initializer for toggling. Used in a *AIGoalMilestoneList*
    ///Use when toggling is option
    init(
        milestone: Milestone,
        onTap: ((Milestone) -> Void)? = nil
    ){
        self.milestone = milestone
        self.rowType = .toggling
        self.onTap = onTap
        self.onDelete = nil
    }
    
    var body: some View {
        HStack(spacing: 15){
            HStack{
                Image(systemName: milestone.systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                VStack(alignment: .leading){
                    Text(milestone.desc)
                        .font(.system(.headline, design: .rounded, weight: .semibold))
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if let dueDate = milestone.dueDate {
                        Text("Due: \(DeadlineFormatter.formatToDayMonth(dueDate))")
                            .font(.system(.subheadline, design: .rounded, weight: .light))
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .foregroundStyle(milestone.isCompleted ? .aiLabel : .aiSecondary2)
            .frame(maxWidth: .infinity)
            .frame(height: milestone.dueDate != nil ? 60 : 50)
            .background(milestone.isCompleted ? .green : .aiSecondary, in: .rect(cornerRadius: 15))
            .onTapGesture {
                onTap?(milestone)
            }
            
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
                    onDelete?(milestone)
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
    AIMilestoneRow(milestone: Milestone.sample, onDelete: {_ in})
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeMilestoneViewModel())
}
