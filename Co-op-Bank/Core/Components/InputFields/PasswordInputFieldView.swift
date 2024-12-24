//
//  PasswordInputFieldView.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 24/12/2024.
//

import SwiftUI

struct PasswordInputFieldView: View {
    @State var isPasswordVisible: Bool
    @Binding var password: String
    @State var description: String
    @State var foregroundColor: Color = Color.theme.blackAndWhite
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image("Paddlock")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(foregroundColor)
                    .frame(width: 20, height: 20)
                    .padding(.bottom, 5)
                
                VStack(alignment: .leading, spacing: 0) {
                    if !password.isEmpty {
                        Text(description)
                            .font(.system(size: 12,
                                          weight: .light,
                                          design: .rounded))
                            .foregroundColor(foregroundColor)
                    }
                    
                    if isPasswordVisible {
                        ZStack(alignment: .leading) {
                            if  password.isEmpty {
                                Text("Password")
                                    .font(.system(size: 17,
                                                  weight: .light,
                                                  design: .rounded))
                                    .foregroundColor(foregroundColor)
                                }
                                TextField("", text:  $password)
                                .font(.system(size: 23,
                                              weight: .light,
                                              design: .rounded))
                                .textFieldStyle(TappableTextFieldStyle()) // Increase tap area
                                    .autocapitalization(.none)
                                    .foregroundColor(foregroundColor)
                                    .font(.system(size: 17, weight: .light, design: .rounded))
                                    .padding(.vertical, 1)
                        }
                    }
                    else {
                        ZStack(alignment: .leading) {
                            if  password.isEmpty {
                                Text("Password")
                                    .foregroundColor(foregroundColor)
                                    .font(.system(size: 17,
                                                  weight: .light,
                                                  design: .rounded))
                                }
                                SecureField("", text: $password)
                                .textFieldStyle(TappableTextFieldStyle()) // Increase tap area
                                    .autocapitalization(.none)
                                    .font(.system(size: 23, weight: .light, design: .rounded))
                                    .foregroundColor(foregroundColor)
                                    .padding(.vertical, 1)
                                    .onTapGesture {
                                        self.endEditing() // Hide keyboard
                                    }
                        }
                    }
                }
                
                
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(isPasswordVisible ? "show_icon" : "show_icon")
                        .renderingMode(.template)
                        .foregroundColor(Color.theme.blackAndWhite)
                        .padding(10)
                }
                .buttonStyle(CustomButtonStyle())

            }
            
            Divider()
                .frame(height: 1)
                .background(foregroundColor)
        }
        
    }
    
    // Dismiss keyboard
    func endEditing() {
           UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
       }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.clear)
            )
          
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.clear, lineWidth: 0)
            )
            .contentShape(RoundedRectangle(cornerRadius: 8)) // Makes the whole button tappable
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

#Preview {
    PasswordInputFieldView(isPasswordVisible: false, password: .constant(""), description: "Password")
}
