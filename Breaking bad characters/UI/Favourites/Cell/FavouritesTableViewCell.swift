//
//  FavouritesTableViewCell.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var characterImage: UIImageView!
    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak var parentView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }

    private func prepareUI() {
        characterImage.layer.cornerRadius = characterImage.frame.height / 2
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    func updateUI(image: Data, name: String) {
        guard let image = UIImage(data: image) else { return }
        
        characterImage.image = image
        self.name.text       = name
    }
}
