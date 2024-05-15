//
//  AuthRepository.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

struct AuthRepository: AuthenticateUserRepositoryProtocol {
    static let shared = AuthRepository()
    let authRemoteDataSource = AuthRemoteDataSource()
    
    func authenticateUser(user: UserRequestEntity) async -> Result<UserResponseEntity, APIError> {
        let userModel = UserRequestModel(entity: user)!
        let authResponseResult = await authRemoteDataSource.authenticateUser(user: userModel)
        
        switch authResponseResult {
        case .success(let authResultData):
            guard let userEntity = UserResponseEntity(model: authResultData) else {
                return .failure(APIError.unkown)
            }
            return .success(userEntity)
        case .failure(let error):
            return .failure(error)
        }
    }
}
