//
//  PrimaryButtonModifier.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .frame(width: UIScreen.main.bounds.width - 80, height: 44)
            .foregroundColor(Color.theme.greenYellow)
            .cornerRadius(10)
            .padding(.top, 24)
    }
}
