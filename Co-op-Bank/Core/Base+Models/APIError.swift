//
//  APIError.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

enum APIError: Error, CustomStringConvertible{
    case badURL
    //case urlSession(URLError?)
    case urlSession(Error)
    case badResponse(Int)
    case decoding(DecodingError)
    case custom(String)
    case unkown
    
    var description: String {
        switch self {
        case .badURL:
            return "Bad URL"
        case .urlSession(let error):
            return "URL session error: \(error.localizedDescription)"
        case .badResponse(let statusCode):
            return "Bad response with status code \(statusCode)"
        case .decoding(let decodingError):
            return "Decoding error \(decodingError.localizedDescription)"
        case .custom(let error):
            return error
        case .unkown:
            return "Unknown error."
        }
    }
}
