//
//  Decoder.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import Foundation

protocol Decoder {
    associatedtype ReturnType: Codable
    func decode(from data: Data?) -> ReturnType?
}

class DefaultDecoder<T: Codable>: Decoder {
    typealias ReturnType = T
    
    let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func decode(from data: Data?) -> ReturnType? {
        guard let data = data else { return nil }
        
        let result = try? decoder.decode(T.self, from: data)
        
        return result
    }
}
