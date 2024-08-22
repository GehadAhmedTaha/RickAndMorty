//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Gehad V on 25/08/2024.
//

import Foundation
import Alamofire
import SwiftyJSON
final class NetworkManager {
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
 
    func performRequest<D: Decodable>(router:Routable, decodeTo: D.Type) async throws -> D? {
        guard let baseUrl = URL(string: self.baseUrl) else {
            throw AFError.invalidURL(url: baseUrl)
        }
        
        guard var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else {
            throw AFError.invalidURL(url: baseUrl)
        }
        components.queryItems = router.queryItems
        
        guard let url = components.url else {
            throw AFError.invalidURL(url: baseUrl)
        }
        var request = URLRequest(url: url)
        request.httpMethod = router.httpMethod
        let (resultData, _ ) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(D.self, from: resultData)
        print(JSON(resultData))
        return result
    }
}
