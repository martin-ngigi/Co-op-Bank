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
    
    @Published var usernameError: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var passwordError: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    @MainActor
    func authenticateUser() async {
        if username.isEmpty && password.isEmpty {
            usernameError = "Username can't be empty"
            passwordError = "Password can't be empty"
            return
        }
        if username.isEmpty {
            usernameError = "Username can't be empty"
            return
        }
        if password.isEmpty {
            passwordError = "Password can't be empty"
            return
        }
        
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
    
    
    
    func valdateUsername() -> String{
        usernameError = username.isEmpty ? "Username can't be empty" : ""
        return usernameError
    }
    
    func valdatePassword() -> String{
        passwordError = password.isEmpty ?  "Password can't be empty" : ""
        return passwordError
    }
}
