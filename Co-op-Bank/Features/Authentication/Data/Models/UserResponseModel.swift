//
//  UserResponseModel.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

struct UserResponseModel: Codable {
    var id: Int
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    var gender: String
    var image: String
    var token: String
    
    init?(entity: UserResponseEntity){
        self.id = entity.id
        self.username = entity.username
        self.email = entity.email
        self.firstName = entity.firstName
        self.lastName = entity.lastName
        self.gender = entity.gender
        self.image = entity.image
        self.token = entity.token
    }
}
