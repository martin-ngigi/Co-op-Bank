//
//  AuthenticateUserRepositoryProtocol.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

protocol AuthenticateUserRepositoryProtocol {
    func authenticateUser(user: UserRequestEntity) async -> Result<UserResponseEntity, APIError>
}
