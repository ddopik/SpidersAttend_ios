//
//  VaildatorFactory.swift
//  SpidersAttend
//
//  Created by ddopik on 6/22/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .username: return UserNameValidator()
        case .projectIdentifier: return ProjectIdentifierValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .age: return AgeValidator()
        }
    }
}
