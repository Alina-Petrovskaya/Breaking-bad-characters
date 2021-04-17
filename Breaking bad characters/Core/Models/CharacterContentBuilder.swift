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
                
                DispatchQueue.main.async {
                    self?.characters = ckaracters
                    self?.callBack?()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                self?.errorAlert?(error)
                }
            }
        }
    }
    
    func buildCellContent(for row: Int, cell: CharacterCollectionViewCell?) -> UICollectionViewCell {
        
        if let imageURL = characters?[row].img, let name = characters?[row].name {
            cell?.updateUI(with: imageURL, name: name)
        }
        
        return cell ?? UICollectionViewCell()
    }
}
