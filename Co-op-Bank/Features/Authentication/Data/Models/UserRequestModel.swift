//
//  UserRequestModel.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

struct UserRequestModel: Codable {
    var username: String
    var password: String
    
    init?(entity: UserRequestEntity){
        self.username = entity.username
        self.password = entity.password
    }
}
