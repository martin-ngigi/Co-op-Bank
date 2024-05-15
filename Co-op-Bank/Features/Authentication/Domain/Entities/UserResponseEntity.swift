//
//  UserResponseEntity.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

struct UserResponseEntity: Codable {
    var id: Int
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    var gender: String
    var image: String
    var token: String
    
    init(
        id: Int,
        username: String,
        email: String,
        firstName: String,
        lastName: String,
        gender: String,
        image: String,
        token: String
    ) {
        self.id = id
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.image = image
        self.token = token
    }
    
    init?(model: UserResponseModel){
        self.id = model.id
        self.username = model.username
        self.email = model.email
        self.firstName = model.firstName
        self.lastName = model.lastName
        self.gender = model.gender
        self.image = model.image
        self.token = model.token
    }
}
