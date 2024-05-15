//
//  HomeViewmodel.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

class HomeViewmodel: ObservableObject {
    @Published var message: String = ""
    
    var homeusecases: Homeusecases = Homeusecases(messageRepository: MessageRepository.shared)
    
    func saveMessage(message: String){
        homeusecases.executeSaveMessage(message: message)
    }

}
