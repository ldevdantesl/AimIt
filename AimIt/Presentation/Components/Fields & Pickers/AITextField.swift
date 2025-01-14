//
//  AITextField.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AITextField: View {
    private let titleName: String
    private let placeholder: String
    private let validationOptions: [FieldCheckerOptions]
    private let submitLabel: SubmitLabel
    private let axis: Axis
    private let width: CGFloat
    
    @Binding var text: String
    @Binding var errorMsg: String?
    
    @FocusState var isFocused: Bool
    
    private let submitAction: (() -> ())?
    
    @State private var isValidated: Bool = false
    @State private var offset: CGFloat = 0
    
    init(
        titleName: String,
        placeholder: String,
        text: Binding<String>,
        errorMsg: Binding<String?>,
        validationOptions: [FieldCheckerOptions] = [
            .isNotEmpty,
            .isNotContainsOnlySpaces,
            .isNotSmallerThan(2)
        ],
        axis: Axis = .horizontal,
        width: CGFloat = .infinity,
        submitLabel: SubmitLabel = .done,
        submitAction: (() -> ())? = nil
    ) {
        self.titleName = titleName
        self.placeholder = placeholder
        self._text = text
        self._errorMsg = errorMsg
        self.validationOptions = validationOptions
        self.axis = axis
        self.width = width
        self.submitLabel = submitLabel
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
            .background(Color.aiSecondary, in: .rect(cornerRadius: UIConstants.textFieldCornerRadius))
            .overlay {
                if isValidated && errorMsg != nil {
                    RoundedRectangle(cornerRadius: UIConstants.textFieldCornerRadius)
                        .stroke(Color.red, lineWidth: 2)
                }
            }
            .focused($isFocused)
            .submitLabel(submitLabel)
            .onSubmit(of: .text) {
                isFocused = false
                validate()
                submitAction?()
            }
            .scrollDismissesKeyboard(.immediately)
            .onChange(of: text) { _ in
                withAnimation {
                    isValidated = false
                }
            }
            .onChange(of: isFocused) { newValue in
                if !newValue {
                    validate()
                }
            }
            .offset(x: offset)
            
            if let errorMsg = errorMsg, !errorMsg.isEmpty, isValidated {
                Text(errorMsg)
                    .font(.system(.caption, design: .rounded, weight: .semibold))
                    .foregroundStyle(.red)
                    .padding(.leading, 10)
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func validate() {
        do {
            try FieldChecker.checkField(value: text, options: validationOptions)
            withAnimation {
                errorMsg = nil
                isValidated = true
            }
        } catch let error as FieldCheckerError {
            withAnimation {
                errorMsg = error.errorDescription
                isValidated = true
            }
            errorAnimation()
        } catch {
            withAnimation {
                errorMsg = "Something is wrong with this field"
                isValidated = true
            }
            errorAnimation()
        }
    }
    
    private func errorAnimation() {
        withAnimation(.easeOut(duration: 0.2)) {
            self.offset = 50
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
                self.offset = 0
                AIHaptics.shared.generate(with: .heavy)
            }
        }
    }
}

#Preview {
    AITextField(
        titleName: "Title",
        placeholder: "Do some shit",
        text: .constant(""),
        errorMsg: .constant("Some error")
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.aiBackground)
}
