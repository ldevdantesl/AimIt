//
//  AIOptionalDatePicker.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.01.2025.
//

import SwiftUI

struct AIOptionalDateField: View {
    @EnvironmentObject var userVM: UserViewModel
    private let titleName: String
    private let widthSize: CGFloat
    private let dateUntil: Date?
    
    @Binding private var chosenDate: Date?
    
    @State private var showSheet: Bool = false
    @State private var choosingDate: Date = Date()
    
    init(
        titleName: String,
        widthSize: CGFloat,
        chosenDate: Binding<Date?>,
        dateUntil: Date? = nil
    ) {
        self.titleName = titleName
        self.widthSize = widthSize
        self._chosenDate = chosenDate
        self.dateUntil = dateUntil
    }
    
    var body: some View {
        VStack(alignment:.leading){
            Text(titleName)
                .font(.system(.headline, design: .rounded, weight: .light))
                .foregroundStyle(.aiSecondary2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
            
            HStack(spacing: 10){
                HStack{
                    if let chosenDate = chosenDate {
                        Text(DeadlineFormatter.formatToDayMonth(chosenDate))
                            .foregroundStyle(.aiLabel)
                            .font(.system(.headline, design: .rounded, weight: .light))
                    } else {
                        Text("No date")
                            .foregroundStyle(.aiLabel)
                            .font(.system(.headline, design: .rounded, weight: .light))
                    }
                    
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
                
                if chosenDate != nil {
                    Button{
                        withAnimation {
                            chosenDate = nil
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(userVM.themeColor)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .onTapGesture {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            VStack{
                DatePicker(
                    "",
                    selection: $choosingDate,
                    in: Date()...(dateUntil ?? .distantFuture),
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding(.horizontal, 20)
                
                AIButton(title: "Done", color: userVM.themeColor) {
                    showSheet.toggle()
                    withAnimation {
                        self.chosenDate = choosingDate
                    }
                }
            }
            .presentationDetents([.medium])
            .presentationBackground(.aiBackground)
            .presentationDragIndicator(.visible)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    AIOptionalDateField(
        titleName: "Due Date",
        widthSize: UIConstants.screenWidth / 2 - 20,
        chosenDate: .constant(nil)
    )
    .preferredColorScheme(.dark)
}
