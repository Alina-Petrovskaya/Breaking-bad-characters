//
//  CharacterRequestBuilder.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import Foundation

protocol RequestBuilder {
    init(url: String)
    
    func buildRequest() -> URLRequest?
}


class CharacterRequestBuilder: RequestBuilder {
    let url: String
    
    required init(url: String) {
        self.url = url
    }
    
    func buildRequest() -> URLRequest? {
        
        guard let components = URLComponents(string: url) else { return nil }
        guard let url = components.url else { return nil }
        
        return URLRequest(url: url)
    }
}
