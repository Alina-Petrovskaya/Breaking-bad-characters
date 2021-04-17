//
//  FavouritesContentManagerModel.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import Foundation

struct FavouritesContentManagerModel: Codable {
    let id: Int
    let image: Data
    let name: String
    let nickName: String
    let birth: String
    let occupation: [String]
    let appearance: [Int]
    let portrayed: String
}
