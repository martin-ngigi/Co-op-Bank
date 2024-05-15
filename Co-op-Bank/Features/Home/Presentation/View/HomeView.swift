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
        NavigationView {
            ZStack {
                // Background image
                Image("nairobi")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                // Color overlay with opacity
                Color.theme.darkGreenColor.opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                
                // content view
                VStack {
                    
                    
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .padding(.top, 30)
                    
                    Text("Welcome \(authenticationViewmodel.user?.firstName ?? "") to the new Co-op Bank app!")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.top, 70)
                    
                    Spacer()

                        
                }
                .frame(width: UIScreen.main.bounds.width - 50)
            }
            .toolbar{
                // Logout button
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // Logout action
                        authenticationViewmodel.isAuthenticated = false
                    }) {
                        HStack {
                            Image(systemName: "arrow.right.circle")
                                .foregroundColor(.white)
                            
                            Text("Logout")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.trailing, 20)
                }
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
