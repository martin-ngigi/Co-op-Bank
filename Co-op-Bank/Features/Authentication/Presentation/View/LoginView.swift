//
//  LoginView.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel : AuthenticationViewmodel // already initialized in App



    var body: some View {
        VStack {
            Spacer()
            
            // Logo image
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            // Welcome Text
            Text("Welcome to Co-op Bank")
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 20)
            
            // Username Field
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.white)
                TextField("Username", text: $viewModel.username)
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                    .padding()
            }
            .padding(10)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 1)
            )
            .padding(.horizontal)
            .padding(.top, 30)
            
            //  Password Field
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.white)
                if viewModel.isPasswordVisible {
                    TextField("Password", text: $viewModel.password)
                        .foregroundColor(.white)
                        .padding()
                } else {
                    SecureField("Password", text: $viewModel.password)
                        .foregroundColor(.white)
                        .padding()
                }
                Button(action: {
                    viewModel.isPasswordVisible.toggle()
                }) {
                    Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.white)
                }
            }
            .padding(10)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 1)
            )
            .padding(.horizontal)
            .padding(.top, 15)
            
            //Results
            if case let .error(error) = viewModel.state{
                Text(error)
                    .foregroundStyle(.red)
                    .padding()
            }
            
            if viewModel.state == .isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            else {
                // Login Button
                Button(action: {
                    // Handle login action
                    Task { await viewModel.authenticateUser() }
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(1.0))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.top, 30)
            }
            
            Spacer()
        }
        .onDisappear{
            viewModel.username = ""
            viewModel.password = ""
        }
        .background(Color.green.opacity(0.6))
        .ignoresSafeArea()
    }
}


#Preview {
    LoginView()
}
