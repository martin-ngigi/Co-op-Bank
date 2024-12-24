//
//  SelectFromView.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 24/12/2024.
//

import SwiftUI

struct SelectFromView: View {
    var image: String = ""
    var title: String
    var subtitle: String = ""
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack(spacing: 0) {
                if !image.isEmpty {
                    Image(image)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.theme.blackAndWhite)
                        .frame(width: 25, height: 25)
                        .padding(.leading, 5)
                }
                VStack(alignment: .leading, spacing: 0){
                    HStack {
                        Text(title)
                            .font(.system(size: 17, weight: .light, design: .rounded))
                            .padding(.leading, 7)
                        
                        Spacer()
                        
                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color.theme.blackAndWhite)
                        
                        
                    }
                    
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.system(size: 12, weight: .light, design: .rounded))
                            .padding(.leading, 7)
                    }
                }
            }
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.theme.blackAndWhite, lineWidth: 1)
            )
        }
        .foregroundColor(Color.theme.blackAndWhite)
    }
}

#Preview {
    SelectFromView(title: "Drop down", action: {})
}
