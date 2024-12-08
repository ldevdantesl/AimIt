//
//  AIDatePicker.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AIDatePicker: View {
    let titleName: String
    let widthSize: CGFloat
    
    @Binding private var chosenDate: Date
    
    @State private var showSheet: Bool = false
    
    init(
        titleName: String,
        widthSize: CGFloat,
        chosenDate: Binding<Date>
    ) {
        self.titleName = titleName
        self.widthSize = widthSize
        self._chosenDate = chosenDate
    }
    
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text(titleName)
                    .font(.system(.headline, design: .rounded, weight: .light))
                    .foregroundStyle(.aiSecondary2)
                
                Spacer()
            }
            .padding(.leading, 10)
            
            HStack{
                Text(DeadlineFormatter.formatToDayMonth(date: chosenDate))
                    .foregroundStyle(.aiLabel)
                    .font(.system(.headline, design: .rounded, weight: .light))
                
                Spacer()
                
                Image(systemName: "calendar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.aiLabel)
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: widthSize)
            .frame(height: 50)
            .background(Color.aiSecondary, in:.rect(cornerRadius: 30))
        }
        .padding(.horizontal, 20)
        .onTapGesture {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            VStack{
                DatePicker(
                    "",
                    selection: $chosenDate,
                    in: Date()...,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                
                Button("Done"){
                    showSheet.toggle()
                }
                .foregroundStyle(.aiOrange)
            }
            .presentationDetents([.medium])
            .presentationBackground(.aiBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    AIDatePicker(titleName: "Due Date", widthSize: UIConstants.screenWidth / 2 - 20, chosenDate: .constant(.now))
        .preferredColorScheme(.dark)
}
