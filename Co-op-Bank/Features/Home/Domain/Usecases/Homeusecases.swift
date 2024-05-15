//
//  Homeusecases.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation
struct Homeusecases {
    let messageRepository: SaveMessageRepositoryProtocol
    
    init(messageRepository: SaveMessageRepositoryProtocol) {
        self.messageRepository = messageRepository
    }
    
    func executeSaveMessage(message: String) {
        messageRepository.saveMessage(message: message)
    }

}
