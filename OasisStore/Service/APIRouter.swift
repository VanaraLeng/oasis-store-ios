//
//  APIRouter.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/16/23.
//

import Foundation

protocol APIRouterProtocol {
    var baseUrl: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var query: [String : String]? { get }
    var parameter: [String : Any]? { get }
}

extension APIRouterProtocol {
    
    var baseUrl: String {
        return "https://private-20516c-oasisstoreapp.apiary-mock.com"
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum NetworkError: LocalizedError {
    case redirectError(url: URL?, code: Int)
    case badUrlResponse(url: URL?, code: Int)
    case unauthorized(url: URL?, code: Int)
    case forbidden(url: URL?, code: Int)
    case serverError(url: URL?, code: Int)
    case unknown
    
    var errorDescription: String? {
        switch self {
        
        case .badUrlResponse(let url, let code):
            return "Bad URL response \(url?.absoluteString ?? "") \(code)"
        
        case .unauthorized(let url, let code):
            return "Unauthorized error \(url?.absoluteString ?? "") \(code)"
            
        case .forbidden(let url, let code):
            return "URL is forbidden \(url?.absoluteString ?? "") \(code)"
        
        case .serverError(let url, let code):
            return "Internal server error \(url?.absoluteString ?? "") \(code)"
        
        case .redirectError(let url, let code):
            return "URL has redirected \(url?.absoluteString ?? "") \(code)"
        case .unknown: return "Unknown error"
        }
    }
}
