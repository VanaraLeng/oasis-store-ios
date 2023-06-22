//
//  HomeReponse.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/16/23.
//

import Foundation

struct HomeResponse: Decodable {
    let success: Bool
    let data: HomeDataResponse
}

struct HomeDataResponse: Decodable {
    let banners : [String]
    let newProducts : [Product]
    let popularProducts: [Product]
}
