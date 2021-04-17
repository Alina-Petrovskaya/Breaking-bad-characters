//
//  Constants.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import Foundation

struct Constants {
    static let shared = Constants()
    
    //Cells
    let characterCell  = "CharacterCollectionViewCell"
    let favouritesCell = "FavouritesTableViewCell"
    
    //Segue
    let fromCharactersToDetail = "FromCharactersToDetail"
    let fromFavouritesToDetail = "FromFavouritesToDetail"
}
