//
//  ToastView.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import SwiftUI

struct ToastView: View {
    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
    var onCancelTapped: () -> Void
    
    var body: some View {
        HStack( alignment: .center, spacing: 12){
            Image(systemName: style.iconFileName)
                .foregroundStyle(style.themeColor)
            
            Text(message)
                .font(.caption)
//                .foregroundColor(Color("toastForeground"))
                .foregroundStyle(.black)

            Spacer(minLength: 10)
            
            Button{
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(style.themeColor)
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
//        .background(Color("toastBackground"))
        .background(.white)
        .cornerRadius(8)
        .overlay {
    
            RoundedRectangle(cornerRadius: 8)
                .stroke(style.themeColor, lineWidth: 2)
        }
        //        .overlay {
        //            RoundedRectangle(cornerRadius: 8)
        //                    .opacity(0.6)
        //        }
        .padding(.horizontal, 16)
        //.sensoryFeedback(.success, trigger: true) // Vibrate
    }
}


//#Preview {
//    ToastView()
//}
