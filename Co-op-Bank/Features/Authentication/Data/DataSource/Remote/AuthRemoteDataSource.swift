//
//  AuthRemoteDataSource.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

class AuthRemoteDataSource{
    func authenticateUser(user: UserRequestModel) async -> Result<UserResponseModel, APIError>{
        guard let url = Constants.APIEndpoint.auth.url else {
            return .failure(APIError.badURL)
        }
        
        return await NetworkUtils.shared.post(returnType: UserResponseModel.self, url: url, postData: user)
    }
}
