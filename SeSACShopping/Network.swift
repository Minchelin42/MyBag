//
//  Network.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/05/08.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidResponse
    case unknown
}

class Network {
    
    static let shared = Network()
    
    static func makeURL(query: String, display: Int, sort: String, start: Int) -> URL {
        return URL(string: "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=\(display)&sort=\(sort)&start=\(start)")!
    }
    
    func callRequestAsyncAwait(query: String, display: Int, sort: String, start: Int) async throws -> Result {
        print(#function)
        
        let url = Network.makeURL(query: query, display: display, sort: sort, start: start)
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
        
        request.addValue(APIKey.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(APIKey.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.unknown //상태코드가 200이 아니라면 error를 던짐
        }

        do {
            let result = try JSONDecoder().decode(Result.self, from: data)
            return result
        } catch {
            throw NetworkError.invalidResponse
        }

    }
 
}
