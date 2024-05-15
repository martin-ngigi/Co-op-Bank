//
//  MessageRepository.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

struct MessageRepository: SaveMessageRepositoryProtocol {
    static let shared = MessageRepository()
    let messageLocalDataSource = MessageLocalDataSource()
    
    func saveMessage(message: String) {
        messageLocalDataSource.saveMessage(message: message)
    }
    
}
