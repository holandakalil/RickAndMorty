//
//  CharacterWebService.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 12/10/20.
//

import Foundation

class CharacterWebService: CharacterWebServiceProtocol {
    
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlString: String = Constants.characterUrl,
         urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func getCharacters(at page: Int = 0,
                          completionHandler: @escaping (AllCharactersResponseModel?, CharacterError?) -> Void) {
        var urlWithPage = urlString
        if page > 0 {
            urlWithPage += "?page=\(page)"
        }
        
        guard let url = URL(string: urlWithPage) else {
            completionHandler(nil, CharacterError.invalidRequestURLString)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = Constants.timeOutTime
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            
            if let _ = error {
                completionHandler(nil, CharacterError.failedRequest)
                return
            }
            
            if let data = data,
               let response = try? JSONDecoder().decode(AllCharactersResponseModel.self, from: data) {
                completionHandler(response, nil)
            } else {
                completionHandler(nil, CharacterError.invalidResponseModel)
            }
        }
        
        dataTask.resume()
    }
}
