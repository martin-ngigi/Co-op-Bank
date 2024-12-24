//
//  MyAlertDialog.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 24/12/2024.
//

import SwiftUI

struct MyAlertDialog: View {
    @Binding var isPresented: Bool
    var title: String
    var text: String
    var confirmButtonText: String = ""
    var dismissButtonText: String
    var imageName: String
    var onDismiss: () -> Void
    var onConfirmation: () -> Void

    var body: some View {
        ZStack {

            if isPresented {
                // Background overlay
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                       // isPresented = false // Dismiss when tapping outside
                    }

                // Alert dialog
                VStack(spacing: 20) {
                    
                    Text(title)
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.theme.primaryColor)

                    if !imageName.isEmpty {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    }
                    
                    
                    Text(text)
                        .font(.system(size: 17, weight: .light, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.black)

                    HStack {

                        if !dismissButtonText.isEmpty {
                            CustomButtonView(buttonName: dismissButtonText, backgroundColor: Color.clear, buttonNameColor: Color.theme.primaryColor) {
                                                        onDismiss()
                                                        isPresented = false
                                                    }
                        }
                        
                        

                    if !confirmButtonText.isEmpty {
                        
                        CustomButtonView(buttonName: confirmButtonText) {
                            onConfirmation()
                            isPresented = false
                        }
                    }
                  }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 20)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.95)
                .padding()
            }
        }
    }
}


#Preview {
    MyAlertDialog(
        isPresented: .constant(true),
        title: "Oops",
        text: "Error occurred",
        confirmButtonText: "Retry",
        dismissButtonText: "Okay",
        imageName: "error",
        onDismiss: {
            
        },
        onConfirmation: {
            
        }
    )
}
