//
//  CharacterCollectionViewCell.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import UIKit
import SDWebImage

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var characterImage: UIImageView!
    @IBOutlet weak private var name: UILabel!
    
    
    func updateUI(with imageURL: String, name: String) {
        self.name.text       = name
        characterImage.sd_setImage(with: URL(string: imageURL))
    }

}
