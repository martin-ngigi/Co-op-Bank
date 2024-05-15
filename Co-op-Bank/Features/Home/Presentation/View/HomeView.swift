//
//  HomeView.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import SwiftUI


struct HomeView: View {
    var userName: String = "JohnDoe" // Replace with dynamic username
    @EnvironmentObject var viewModel : AuthenticationViewmodel // already initialized in App

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
                Text("Welcome \(userName) to the new Co-op Bank app!")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
        }
        .toastView(toast: $viewModel.toast)
    }
}

#Preview {
    HomeView()
}
