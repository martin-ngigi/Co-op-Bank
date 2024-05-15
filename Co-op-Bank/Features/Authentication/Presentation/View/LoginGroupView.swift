//
//  LoginGroupView.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import SwiftUI

struct LoginGroupView: View {
    @EnvironmentObject var viewModel : AuthenticationViewmodel // already initialized in App

    var body: some View {
        Group {
            if viewModel.isAuthenticated {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    LoginGroupView()
}
