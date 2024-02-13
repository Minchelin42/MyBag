//
//  SearchAPIManager.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/02/13.
//

import Foundation

enum APIError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

class SearchAPIManager {
    
    static func callRequest(query: String, sort: String, start: Int, completionHandler: @escaping (Result?, APIError?) -> Void) {
        let scheme = "https"
        let host = "openapi.naver.com"
        let path = "/v1/search/shop.json"
        
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let display = 30
        let sort = sort
        let start = start
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        
        component.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "display", value: String(display)),
            URLQueryItem(name: "start", value: String(start))
        ]
        
        var url = URLRequest(url: component.url!)
        print(url)
        url.httpMethod = "GET"
        url.addValue(APIKey.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        url.addValue(APIKey.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("네 통 실")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("통신 성공, 데이터는 x")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("통신은 성공했지만, 응답값(ex. 상태코드)이 오지 않음")
                    completionHandler(nil, .invalidResponse)
                    return
                }

                guard response.statusCode == 200 else {
                    print("통신은 성공했지만, 올바른 값이 오지 않은 상태")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try
                    JSONDecoder().decode(Result.self, from: data)
                    dump(result)
                    completionHandler(result, nil)
                } catch {
                    print(error)
                    completionHandler(nil, .invalidData)
                }
                
            }
            
        }.resume()
    }
}

