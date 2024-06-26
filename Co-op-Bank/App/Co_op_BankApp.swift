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
    @StateObject var homeViewmodel = HomeViewmodel()

    var body: some Scene {
        WindowGroup {
            LoginGroupView()
                .environmentObject(authenticationViewmodel)
                .environmentObject(homeViewmodel)

        }
    }
}
