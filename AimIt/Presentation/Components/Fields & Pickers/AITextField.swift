//
//  AITextField.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AITextField: View {
    let titleName: String
    let placeholder: String
    let axis: Axis
    let width: CGFloat
    
    @Binding var text: String
    
    @FocusState var isFocused: Bool
    
    let submitAction: (() -> ())?
    
    init(
        titleName: String,
        placeholder: String,
        text: Binding<String>,
        axis: Axis = .horizontal,
        width: CGFloat = .infinity,
        submitAction: (() -> ())? = nil
    ) {
        self.titleName = titleName
        self.placeholder = placeholder
        self._text = text
        self.axis = axis
        self.width = width
        self.submitAction = submitAction
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Text(titleName)
                    .font(.system(.headline, design: .rounded, weight: .light))
                    .foregroundStyle(.aiSecondary2)
                Spacer()
            }
            .padding(.leading, 10)
            
            TextField(text: $text, axis: axis) {
                Text("Example: \(placeholder)")
                    .foregroundStyle(.aiSecondary2)
            }
            .padding()
            .foregroundStyle(.aiLabel)
            .frame(maxWidth: width)
            .frame(minHeight: 50)
            .background(Color.aiSecondary, in: .rect(cornerRadius: 25))
            .focused($isFocused)
            .submitLabel(.done)
            .onSubmit(of: .text) {
                isFocused = false
                submitAction?()
            }
            .toolbar {
                if axis == .vertical{
                    ToolbarItem(placement: .keyboard) {
                        Button(action: hideKeyboard){
                            Text("DONE")
                                .foregroundStyle(.aiOrange)
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AITextField(titleName: "Title", placeholder: "Do some shit", text: .constant(""))
        .preferredColorScheme(.dark)
}
