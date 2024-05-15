//
//  AuthenticationViewmodel.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

class AuthenticationViewmodel: ObservableObject {
    
    @Published var authUseCase: AuthUsecases = AuthUsecases(authenticateUserRepository: AuthRepository.shared)
    
    @Published var state = FetchState.good

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var isAuthenticated: Bool = false
    
    @Published var user: UserResponseEntity?
    @Published var toast: Toast? = nil
    
    @MainActor
    func authenticateUser() async {
        state = FetchState.isLoading
        
        let user: UserRequestEntity = UserRequestEntity(username: username, password: password)
        
        let results = await authUseCase.executeAuthenticateUser(user: user)
        
        switch results {
        case .success(let userResult):
            state = .good
            isAuthenticated = true
            print("DEBUG: Retrieved user successfully. User firstName is \(userResult.firstName)")
            toast = Toast(style: .success, message: "Hello \(userResult.firstName)!, Welcom to Co-op Bank.")

            self.user = userResult
        case .failure(let error):
            print("Failed to retrieve user with error \(error.description)")
            isAuthenticated = false
            toast = Toast(style: .error, message: error.description)
            state = .error(error.description)
        }
        
    }
}
