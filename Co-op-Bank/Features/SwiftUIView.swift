//
//  SwiftUIView.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import SwiftUI

struct SwiftUIView: View {
    @State var name: String = ""
    var body: some View {
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
                Text("Hello, World!")
                    .font(.title)
                    .foregroundColor(.white)
                
                // Username Field
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.white)
                    TextField("Username", text: $name)
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                        .padding()
                    
                }
                .padding(.horizontal, 10)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                )
                .padding(.top, 30)
                    
            }
            .frame(width: UIScreen.main.bounds.width - 50)
        }

    }
}
#Preview {
    SwiftUIView()
}
