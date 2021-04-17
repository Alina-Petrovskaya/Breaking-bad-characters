//
//  DetailViewController.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import UIKit

typealias CharacterInformation = (id: Int, image: UIImage, name: String, nickName: String, birth: String, occupation: [String], appearance: [Int], portrayed: String)

class DetailViewController: UIViewController {
    
    enum TypeOfText {
        case contentText
        case titleText
    }
    
    @IBOutlet weak private var characterImage: UIImageView!
    @IBOutlet weak private var characterDescription: UITextView!
    @IBOutlet weak private var saveButton: UIBarButtonItem!
    var charakterInformation: CharacterInformation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareTextView()
    }
    
    private func prepareUI() {
        characterImage.image = charakterInformation?.image
        characterImage.layer.cornerRadius  = characterImage.frame.height / 2
        characterImage.layer.masksToBounds = true
        
        
        saveButton.tintColor = (FavouritesContentManager.shared.arrayOfCharacters.firstIndex(where: { (character) -> Bool in
            character.id == charakterInformation?.id
            }) != nil) ? #colorLiteral(red: 0.9529411793, green: 0.4364395661, blue: 0.1333333403, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    
    private func prepareTextView() {
        guard let charakterInformation = charakterInformation else { return }
        
        let appearanceString = (charakterInformation.appearance.map { String($0)}).joined(separator: ", ")
        
        let name       = "\(charakterInformation.name) (\(charakterInformation.nickName))"
        let birth      = "Birth \(charakterInformation.birth) \n"
        let occupation = "Occupation: \(charakterInformation.occupation.joined(separator: "\n"))"
        let seasons    = "Seasons: \(appearanceString) \n"
        let portrayed  = "Portrayed charakterInformation.portrayed"
        
        //construct TextView
        let attributedContent = NSMutableAttributedString()
        
        attributedContent.append(createAtributedText(text: name, textType: .titleText))
        attributedContent.append(createAtributedText(text: birth, textType: .contentText))
        attributedContent.append(createAtributedText(text: occupation, textType: .contentText))
        attributedContent.append(createAtributedText(text: seasons, textType: .contentText))
        attributedContent.append(createAtributedText(text: portrayed, textType: .titleText))
        
        characterDescription.attributedText = attributedContent
    }
    
    private func createAtributedText(text: String, textType: TypeOfText) -> NSAttributedString {
        
        let font = getFontSize(textType: textType)
        
        let attributes = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: "\(text) \n", attributes: attributes)
        
        return attributedText
    }
    
    
    private func getFontSize(textType: TypeOfText) -> UIFont {
        switch textType {
        case .contentText:
            
            return UIFont.systemFont(ofSize: 18)
            
        case .titleText:
            return UIFont.boldSystemFont(ofSize: 21)
            
        }
    }
    
    
    @IBAction func addToFavouritesTapped(_ sender: UIBarButtonItem) {
        
        if saveButton.tintColor == #colorLiteral(red: 0.9529411793, green: 0.4364395661, blue: 0.1333333403, alpha: 1) {
            FavouritesContentManager.shared.deleteItem(character: charakterInformation?.id)
            saveButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
        } else {
            guard let item = charakterInformation, let imageData = item.image.pngData() else { return }
            
            let character = FavouritesContentManagerModel(id: item.id,
                                                          image: imageData,
                                                          name: item.name,
                                                          nickName: item.nickName,
                                                          birth: item.birth,
                                                          occupation: item.occupation,
                                                          appearance: item.appearance,
                                                          portrayed: item.portrayed)
            
            FavouritesContentManager.shared.saveItem(item: character)
            saveButton.tintColor = #colorLiteral(red: 0.9529411793, green: 0.4364395661, blue: 0.1333333403, alpha: 1)
        }
    }
}
