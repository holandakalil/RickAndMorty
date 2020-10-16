//
//  FavoriteWebService.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 15/10/20.
//

import Foundation

class FavoriteWebService: FavoritesWebServiceProtocol {
    
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlString: String = Constants.characterUrl,
         urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func getFavoritedCharacters(with charactersId: [Int], completionHandler: @escaping ([CharacterModel]?, CharacterError?) -> Void) {
        let charactersIdString = urlString.isEmpty ? "" : charactersId.map{String($0)}.joined(separator: ",")
        guard let url = URL(string: urlString + charactersIdString) else {
            completionHandler(nil, CharacterError.invalidRequestURLString)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            
            if let requestError = error {
                completionHandler(nil, CharacterError.failedRequest(description: requestError.localizedDescription))
                return
            }
            
            if let data = data,
               let response = try? JSONDecoder().decode([CharacterModel].self, from: data) {
                completionHandler(response, nil)
            } else if let data = data,
                      let response = try? JSONDecoder().decode(CharacterModel.self, from: data) {
                completionHandler([response], nil)
            } else {
                completionHandler(nil, CharacterError.invalidResponseModel)
            }
        }
        
        dataTask.resume()
    }
}
