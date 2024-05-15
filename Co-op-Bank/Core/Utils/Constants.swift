//
//  Constants.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

import SwiftUI

class Constants{
    static let COOPBaseURL: String = "https://dummyjson.com"
    static let timeoutInterval: Double = 30.0
    static var accessToken: String = ""
    static let authURL: String = "/auth/login"

    enum APIEndpoint{
        case auth
        var url: URL? {
            switch self {
            case .auth:
                return URL(string: "\(COOPBaseURL)\(authURL)")
            }
        }

    }
}
