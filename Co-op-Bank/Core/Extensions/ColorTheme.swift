//
//  ColorTheme.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation
import SwiftUI

struct ColorTheme {
    let darkGreenColor = Color("DarkGreenColor")
    let greenYellow = Color("GreenYellow")
    let blackAndWhite = Color("BlackAndWhite")
    let whiteAndBlack = Color("WhiteAndBlack")
    let primaryColor = Color("DarkGreenColor")

}

extension Color {
    static let theme = ColorTheme()
}
