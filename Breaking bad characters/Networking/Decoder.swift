//
//  Decoder.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import Foundation

class DefaultDecoder {
    
    let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func decode(from data: Data?) -> [Character]? {
        guard let data = data else { return nil }
        
        let result = try? decoder.decode([Character].self, from: data)
        
        return result
    }
}
