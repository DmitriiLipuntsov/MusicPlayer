//
//  NetworkService.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 11/06/2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func featchTracks(searchText: String,
                      complition: @escaping (Result<SearchResponse, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func featchTracks(searchText: String,
                      complition: @escaping (Result<SearchResponse, Error>) -> Void) {
        
        let url = "https://itunes.apple.com/search"
        let parameters = [
            "term":"\(searchText)",
            "limit":"10",
            "media":"music"
        ]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { dataResponse in
            if let error = dataResponse.error {
                complition(.failure(error))
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            do {
                let objects = try JSONDecoder().decode(SearchResponse.self, from: data)
                complition(.success(objects))
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                complition(.failure(jsonError))
            }
        }
        
    }
    
    
}
