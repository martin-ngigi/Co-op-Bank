//
//  InputFieldView.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 24/12/2024.
//

import SwiftUI

struct InputFieldView: View {
    var image: String = ""
    var description: String = ""
    var placeHolder: String = ""
    @Binding var text: String
    var foregroundColor: Color = Color.theme.blackAndWhite
    var keyboardType: UIKeyboardType = .default
    var dividerColor: Color = Color.theme.blackAndWhite
    var errorMessage: String = ""


    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                
                if !image.isEmpty {
                    Image(image)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(foregroundColor)
                        .frame(width: 20, height: 20)
                }
                            
                VStack(alignment: .leading, spacing: 0) {

                    if !text.isEmpty {
                        Text(description)
                            .font(.system(size: 12,
                                          weight: .light,
                                          design: .rounded))
                            .foregroundColor(foregroundColor)
                    }
                    
                    ZStack(alignment: .leading) {
                        if  text.isEmpty {
                            Text(description)
                                .font(.system(size: 17,
                                              weight: .light,
                                              design: .rounded))
                                .foregroundColor(foregroundColor)
                            }
                        TextField("", text: $text)
                                .textFieldStyle(TappableTextFieldStyle()) // Increase tap area
                                .keyboardType(keyboardType)
                                //.autocapitalization(.sentences)  // Capitalize the first letter of each word/sentence
                                //.textInputAutocapitalization(.sentences) // For iOS 15 and above/sentence
                                .font(.system(size: 20, weight: .light, design: .rounded))
                                .foregroundColor(foregroundColor)
                                .padding(.vertical, 1)
                                .onTapGesture {
                                    self.endEditing() // Hide keyboard
                                }
                    }
                }
            }
            
            Divider()
                .frame(height: 0.5)
                .background(!errorMessage.isEmpty ? .red : dividerColor)
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.system(size: 12,
                                  weight: .light,
                                  design: .rounded))
                    .foregroundColor(Color.red)
                    .padding(.top,4)
            }
        }
        
    }
    
    // Dismiss keyboard
    func endEditing() {
           UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
       }
}

struct EnlargedInputField: View {
    @Binding var text: String

    var body: some View {
        TextField("", text: $text)
            .textFieldStyle(TappableTextFieldStyle())
            .background(Color.gray.opacity(0.2)) // Optional: Visualize the field area
            .cornerRadius(8)
    }
}

struct TappableTextFieldStyle: TextFieldStyle { // https://stackoverflow.com/questions/56795712/swiftui-textfield-touchable-area
    @FocusState private var textFieldFocused: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical) // only vertical padding
            //.background(Color.gray)
            .focused($textFieldFocused)
            .onTapGesture {
                textFieldFocused = true
            }
    }
}
