//
//  MessageLocalDataSource.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

import CoreData

class MessageLocalDataSource {
    private let viewContext = CoreDataProvider.shared.persistentContainer.viewContext

    func saveMessage(message: String) {
        let messageModel = MesageModel(context: viewContext)
        messageModel.welcome_message = message
        save()
    }
    
    private func save() {
        do {
            try viewContext.save()
        }
        catch {
            print("DEBUG: Failed to save with error \(error.localizedDescription)")
        }
    }
}
