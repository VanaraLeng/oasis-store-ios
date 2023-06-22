//
//  NetworkUtil.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/16/23.
//

import Foundation
import Combine

class NetworkUtil {
    
    static func download(url: URLRequest) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try handleMap(out: $0, url: url.url) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private static func handleMap(out: URLSession.DataTaskPublisher.Output, url: URL?) throws -> Data  {
        guard let res = out.response as? HTTPURLResponse else {
            throw NetworkError.badUrlResponse(url: url, code: 0)
        }
        let statusCode = res.statusCode
        
        switch res.statusCode {
        case 200..<300:
            return out.data
        
        case 401:
            throw NetworkError.unauthorized(url: url, code: statusCode)
            
        case 403:
            throw NetworkError.forbidden(url: url, code: statusCode)
            
        case 300..<400:
            throw NetworkError.redirectError(url: url, code: statusCode)
            
        case 400..<500:
            throw NetworkError.badUrlResponse(url: url, code: statusCode)
            
        case 500..<600:
            throw NetworkError.serverError(url: url, code: statusCode)
            
        default:
            throw NetworkError.unknown
        }
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

extension APIRouterProtocol {
    
    var asRequest: URLRequest {
        // Default query
        let langQuery = [ URLQueryItem(name: "lang", value: "en")]
        var urlComponent = URLComponents(string: baseUrl)!
        urlComponent.queryItems = langQuery
        let url = urlComponent.url!.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        
        // header
        request.setValue("iOS", forHTTPHeaderField: "Platform")
        
        if let token = KeychainUtil.shared.retrieve(service: .accessToken) {
            request.setValue("Bearer " + token , forHTTPHeaderField: "Authorization")
        }
        
        // method
        request.httpMethod = method.rawValue
        
        // body
        if let parameters = parameter {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        return request
    }
}
