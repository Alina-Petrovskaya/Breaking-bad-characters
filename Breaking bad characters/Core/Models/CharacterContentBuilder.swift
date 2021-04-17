//
//  CharacterContentBuilder.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import UIKit

class CharacterContentBuilder {
    private let newsService = NetworkingService()
    var callBack: (() -> ())?
    var errorAlert: ((Error) -> ())?
    var characters: [Character]?
    
    
    func getAllCharacters() {
        
        newsService.requestData { [weak self] (result) in
            switch result {
            
            case .success(let ckaracters):
                self?.characters = ckaracters
                self?.callBack?()
                
            case .failure(let error):
                self?.errorAlert?(error)
            }
        }
    }
}
