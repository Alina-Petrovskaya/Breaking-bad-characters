//
//  ApiResponse.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import Foundation

struct ApiResponse: Codable {
    
    let status: String
    let totalResults: Int?
    let characters: [Character]
}
