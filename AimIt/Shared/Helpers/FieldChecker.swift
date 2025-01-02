//
//  FieldChecker.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 2.01.2025.
//

import Foundation

public enum FieldCheckerError: Error, LocalizedError {
    case isEmpty
    case containsOnlySpaces
    case containsOnlyDigits
    case smallerThan(Int)
    case largerThan(Int)
    
    public var errorDescription: String? {
        switch self {
        case .isEmpty:
            return "The field is empty."
        case .containsOnlySpaces:
            return "The field contains only spaces."
        case .containsOnlyDigits:
            return "The field contains only digits."
        case .smallerThan(let minLength):
            return "The field must be at least \(minLength + 1) characters long."
        case .largerThan(let maxLength):
            return "The field must be at most \(maxLength + 1) characters long."
        }
    }
}

public enum FieldCheckerOptions {
    case isNotEmpty
    case isNotContainsOnlySpaces
    case isNotContainsOnlyDigits
    case isNotSmallerThan(Int)
    case isNotLargerThan(Int)
    
    var condition: (String) -> Result<Void, FieldCheckerError> {
        switch self {
        case .isNotEmpty:
            return { $0.isEmpty ? .failure(.isEmpty) : .success(()) }
        case .isNotContainsOnlySpaces:
            return { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .failure(.containsOnlySpaces) : .success(()) }
        case .isNotContainsOnlyDigits:
            return { $0.allSatisfy(\.isNumber) ? .failure(.containsOnlyDigits) : .success(()) }
        case .isNotSmallerThan(let minLength):
            return { $0.count <= minLength ? .failure(.smallerThan(minLength)) : .success(()) }
        case .isNotLargerThan(let maxLength):
            return { $0.count >= maxLength ? .failure(.largerThan(maxLength)) : .success(()) }
        }
    }
}

public struct FieldChecker {
    static func checkField(
        value: String,
        options: [FieldCheckerOptions] = [.isNotEmpty, .isNotContainsOnlySpaces]
    ) throws {
        guard !options.isEmpty else { return }
        for option in options {
            let result = option.condition(value)
            switch result {
            case .success:
                continue
            case .failure(let error):
                throw error
            }
        }
    }
}
