//
//  ProductService.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/16/23.
//

import Foundation
import Combine

class ProductService: ProductServiceProtocol {
    
    func getHomeData() -> AnyPublisher<HomeResponse, NetworkError>  {
        let url = ProductRouter.home.asRequest
        return NetworkUtil.download(url: url)
            .decode(type: HomeResponse.self, decoder: JSONDecoder())
            .mapError(NetworkUtil.mapError)
            .eraseToAnyPublisher()
    }
}
