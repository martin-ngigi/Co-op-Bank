//
//  Co_op_BankApp.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import SwiftUI

@main
struct Co_op_BankApp: App {
    @StateObject var authenticationViewmodel = AuthenticationViewmodel()

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(authenticationViewmodel)

        }
    }
}
