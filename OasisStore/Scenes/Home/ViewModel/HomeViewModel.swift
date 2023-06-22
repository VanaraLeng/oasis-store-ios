//
//  HomeViewModel.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var newProducts: [Product] = []
    @Published var PopularProducts: [Product] = []
    @Published var banners: [String] = []
    
    @Published var isLoading = false
    
    @Published var error: String?
    @Published var showError = false
    
    var dataService: ProductService
    var cancellables: Set<AnyCancellable> = []
    
    init(dataService: ProductService = ProductService()) {
        self.dataService = dataService
    }
    
    func fetchData() {
        isLoading = true
        dataService.getHomeData()?.sink(receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            switch completion {
            case .finished:
                break
                
            case .failure(let error):
                self?.showError = true
                self?.error = error.localizedDescription
            }
            
            
        }, receiveValue: { [weak self] response in
            
            if response.success == true {
                self?.newProducts = response.data.newProducts
                self?.PopularProducts = response.data.popularProducts
                self?.banners = response.data.banners
            }
        })
        .store(in: &cancellables)
    }
}
