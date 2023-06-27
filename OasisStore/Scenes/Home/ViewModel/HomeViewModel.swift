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
    @Published var popularProducts: [Product] = []
    @Published var banners: [String] = []
    
    @Published var isLoading = false
    
    @Published var error: String?
    @Published var showError = false
    
    private var dataService: ProductServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(dataService: ProductServiceProtocol) {
        self.dataService = dataService
    }
    
    func fetchHomeData() {
        isLoading = true
        dataService.getHomeData().sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                self?.isLoading = false
                break
                
            case .failure(let error):
                self?.showError = true
                self?.error = error.localizedDescription
            }
            
        }, receiveValue: { [weak self] response in
            if response.success == true {
                self?.newProducts = response.data.newProducts
                self?.popularProducts = response.data.popularProducts
                self?.banners = response.data.banners
            }
        })
        .store(in: &cancellables)
    }
}
