//
//  ContentView.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HomeViewModel()
    
    @State private var showSideMenu = false
    @State private var selectedProduct: Product?
    @State private var showDetail: Bool = false
    
    var body: some View {
        ZStack (alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 0) {
                
                HeaderView(title: "Home",
                           leftIconName: "sidebar.left",
                           rightIconName: "cart.fill",
                           delegate: self)
            
                if vm.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if !vm.showError {
                    contentView
                }
                
                Spacer()
            }
         
            SideMenuView(showSideMenu: $showSideMenu)
        }
        .task {
            if vm.newProducts.isEmpty {
                vm.fetchData()
            }
        }
        .refreshable {
            vm.fetchData()
        }
        .navigationDestination(isPresented: $showDetail, destination: {
            if let selectedProduct = selectedProduct {
                ProductDetailView(product: selectedProduct)
            }
        })
        .toolbarBackground(.hidden, for: .navigationBar)
        .alert(vm.error ?? "Error", isPresented: $vm.showError) {
            Button("Retry", role: .cancel) {
                vm.fetchData()
            }
        }
        
    }
    
    func onProductTap(product: Product) {
        selectedProduct = product
        showDetail = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.vm)
            
    }
}

extension HomeView: HeaderViewDelegate {
    
    func onLeftButtonPress() {
        withAnimation(.spring(response: 0.2)) {
            showSideMenu.toggle()
        }
    }
    
    func onRightButtonPress() {
        
    }
}

extension HomeView {
    
    var contentView: some View {
        ScrollView {
            
            BannerView(images: vm.banners)
            
            VStack {
                ProductSectionView(title: "New Products", products: $vm.newProducts, onItemTap: onProductTap)
                
                Spacer()
                
                ProductSectionView(title: "Popular Products", products: $vm.newProducts, onItemTap: onProductTap)
            }
        }
    }
       
}
