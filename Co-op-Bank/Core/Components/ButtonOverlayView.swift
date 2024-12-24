//
//  ButtonOverlayView.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 24/12/2024.
//

import SwiftUI

import SwiftUI

struct ButtonOverlayView: View {
    var buttonName: String
//    var width: Double = (UIScreen.main.bounds.width - 40)
    var width: Double = .infinity
    var height: Double = .infinity
    var icon: String=""
    var image: String=""
    var foregroundStyle: Color = Color.white
    var backgroundColor: Color = Color.theme.primaryColor
    var overlayColor: Color = Color.black
    var borderColor: Color = Color.theme.primaryColor
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack{
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            overlayColor.opacity(0.0),
                            overlayColor.opacity(0.0),
                            overlayColor.opacity(0.1),
                            overlayColor.opacity(0.2),
                            overlayColor.opacity(0.3),
                            overlayColor.opacity(0.35),
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                HStack {
                    Text(buttonName)
                        .font(.headline.weight(.semibold))
                    if(!icon.isEmpty){
                        Image(systemName: icon)
                    }
                    
                    if(!image.isEmpty){
                        Image(image)
                    }
                    
                }
            }
            .foregroundColor(foregroundStyle)
            .frame(maxWidth: width, maxHeight: height)
            .frame(height: height) // Solve the maxHeight issue
        }
        .background(backgroundColor)
        .cornerRadius(7)
        .overlay(
               RoundedRectangle(cornerRadius: 7)
                   .stroke(borderColor, lineWidth: 1)
           )

    }
}

#Preview {
    ButtonOverlayView(buttonName: "ButtonName", icon: "arrow.right") {
        print("You clicked CustomButtonView")
    }
}
