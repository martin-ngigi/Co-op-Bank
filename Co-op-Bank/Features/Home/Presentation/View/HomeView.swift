//
//  HomeView.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import SwiftUI


struct HomeView: View {
    @EnvironmentObject var authenticationViewmodel : AuthenticationViewmodel // already initialized in App
    @EnvironmentObject var viewModel : HomeViewmodel // already initialized in App

    var body: some View {
        ZStack {
            // Background color and image
            Color.green
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    Image("nairobi")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.1)
                )
            
            VStack(alignment: .center) {
                
                HStack{
                    Spacer()
                    
                    Button(action: {
                        // Logout action
                        authenticationViewmodel.isAuthenticated = false
                    }) {
                        HStack {
                            Text("Logout")
                                .foregroundColor(.white)
                            Image(systemName: "arrow.right.circle")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.trailing, 20)
                }
                
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.leading, 20)
                    .padding(.top, 50)
                
                Spacer()
                
                // Welcome message
                Text("Welcome \(authenticationViewmodel.user?.firstName ?? "") to the new Co-op Bank app!")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
        }
        .onAppear{
            viewModel.message = authenticationViewmodel.toast?.message ?? ""
        }
        .toastView(toast: $authenticationViewmodel.toast)
    }
}

//#Preview {
//    HomeView()
//}
