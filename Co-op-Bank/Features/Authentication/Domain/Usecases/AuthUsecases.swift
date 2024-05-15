//
//  AuthUsecases.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

class AuthUsecases {
    let authenticateUserRepository :AuthenticateUserRepositoryProtocol

    init(authenticateUserRepository: AuthenticateUserRepositoryProtocol) {
        self.authenticateUserRepository = authenticateUserRepository
    }
    
    func executeAuthenticateUser(user: UserRequestEntity) async -> Result<UserResponseEntity, APIError> {
        return await authenticateUserRepository.authenticateUser(user: user)
    }

}
