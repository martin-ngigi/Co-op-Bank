//
//  UserRequestEntity.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

struct UserRequestEntity{
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    init?(model: UserRequestModel){
        self.username = model.username
        self.password = model.password
    }
}
