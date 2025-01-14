//
//  AITimeProgressBar.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.01.2025.
//

import SwiftUI

struct AITimeProgressBar: View {
    private var createdDate: Date
    private var dueDate: Date
    private var datePassedAction: (() -> ())?
    
    @State private var progressWidth: CGFloat = 0
    
    init(
        createdDate: Date,
        dueDate: Date,
        datePassedAction: (() -> ())? = nil
    ) {
        self.createdDate = createdDate
        self.dueDate = dueDate
        self.datePassedAction = datePassedAction
    }
    
    var body: some View {
        ZStack(alignment:.leading) {
            Capsule()
                .fill(Color.accentColor)
                .frame(width: max(progressWidth, minCapsuleWidth), height: 20)
                .zIndex(2)
                .overlay {
                    if isDayPassed {
                        Button{
                            datePassedAction?()
                            AIHaptics.shared.generate(with: .light)
                        } label:{
                            Text("Change Deadline")
                                .font(.system(.subheadline, design: .rounded, weight: .bold))
                                .foregroundStyle(.aiLabel)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
            
            Capsule()
                .fill(Color.aiSecondary)
                .frame(height: 20)
                .zIndex(1)
        }
        .onAppear {
            let screenWidth = UIConstants.screenWidth - 40
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.linear) {
                    self.progressWidth = screenWidth * CGFloat(timeGone / totalTime)
                }
            }
        }
    }
    
    // MARK: - Constants
    private let minCapsuleWidth: CGFloat = 10
    
    // MARK: - Calculations
    private var totalTime: TimeInterval {
        return max(dueDate.timeIntervalSince(createdDate), 1)
    }
    
    private var isDayPassed: Bool {
        DeadlineFormatter.isDayPassed(dueDate)
    }
    
    private var timeGone: TimeInterval {
        return max(min(Date().timeIntervalSince(createdDate), totalTime), 0)
    }
}

#Preview {
    AITimeProgressBar(createdDate: .now, dueDate: .now + 100)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
