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
    
    static func mapError(error: Error) -> NetworkError {
        switch error {
        case is URLError:
            return .urlError(error as? URLError)
            
        case is APIError:
            return .api(error as? APIError)
            
        case is DecodingError:
            return .decode
            
        default:
            return .unknown
        }
    }
    
    private static func handleMap(out: URLSession.DataTaskPublisher.Output, url: URL?) throws -> Data  {
        guard let res = out.response as? HTTPURLResponse else {
            throw APIError.badRequest(url: url)
        }
        
        let statusCode = res.statusCode
        
        switch statusCode {
        case 200..<300:
            return out.data
        
        case 401:
            throw APIError.unauthorized(url: url)
            
        case 403:
            throw APIError.forbidden(url: url)
            
        case 300..<400:
            throw APIError.redirectError(url: url)
            
        case 400..<500:
            throw APIError.badRequest(url: url)
            
        case 500..<600:
            throw APIError.serverError(url: url)
            
        default:
            throw APIError.unknown
        }
    }
}
