//
//  AIGrowthIllustration.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 15.01.2025.
//

import Foundation
import SwiftUI

struct AIGrowthIllustration: View {
    var body: some View {
        HStack(spacing: 0){
            Image(ImageNames.growth)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 80)
            
            Text("Analytics, even on a small scale, can be a powerful tool for achieving incredible aims.")
                .font(.system(.callout, design: .rounded, weight: .light))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(.trailing, 10)
                .foregroundStyle(.aiSecondary2)
        }
        .background(Color.aiSecondary, in: .rect(cornerRadius: 15))
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 120)
    }
}

#Preview {
    AIGrowthIllustration()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
