//
//  AIDateCapsule.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import SwiftUI

struct AIDateCapsule: View {
    
    let date: Date
    
    init(date: Date) {
        self.date = date
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.aiSecondary)
                .frame(width: 65, height: 75)
            
            VStack(alignment: .center){
                Text(DeadlineFormatter.formatToOnlyDay(date: date))
                    .font(.system(.title3, design: .rounded, weight: .bold))
                
                Text(DeadlineFormatter.formatToOnlyWeekday(date: date).prefix(3))
                    .font(.system(.headline, design: .rounded, weight: .semibold))
            }
            .foregroundStyle(.aiLabel)
            .padding(.top, 12)
        }
        .frame(width: 65, height: 75)
    }
}

#Preview {
    AIDateCapsule(date: .now)
}
