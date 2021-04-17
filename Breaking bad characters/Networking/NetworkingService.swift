//
//  NetworkingService.swift
//  Breaking bad characters
//
//  Created by Alina Petrovskaya on 17.04.2021.
//

import Foundation

class NetworkingService {
    
    private struct Constants {
        static let urlToGetAllCharacters = "https://breakingbadapi.com/api/characters"
    }
    
    private let requestBuilder: RequestBuilder
    
    init(requestBuilder: RequestBuilder = CharacterRequestBuilder(url: Constants.urlToGetAllCharacters)) {
        self.requestBuilder = requestBuilder
    }
    
    func requestData(completion: @escaping (Result<[Character], Error>) -> ()) {
        let session = URLSession.shared
        
        guard let requset = requestBuilder.buildRequest() else {
            completion(.failure(ErrorDecoder.unableToCreateRequest))
            return
        }
                
        let task = session.dataTask(with: requset) { data, _, error in
            guard error == nil else {
                    completion(.failure(error!))
                return
            }
            
            let decoder  = DefaultDecoder()
            
            guard let characters = decoder.decode(from: data) else {
                completion(.failure(ErrorDecoder.unableToDecode))
                return
            }
            
            completion(.success(characters))
        }
        
        task.resume()
    }
}
