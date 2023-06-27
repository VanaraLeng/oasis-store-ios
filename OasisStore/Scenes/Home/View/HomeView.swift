//
//  ContentView.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HomeViewModel(dataService: ProductService())
    
    @State private var showSideMenu = false
    @State private var selectedProduct: Product?
    @State private var showDetail = false
    @State private var showLogin = false
    @State private var showLanguage = false
    @State private var showOrder = false
    @State private var showCart = false
    
    var body: some View {
        ZStack (alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 0) {
                headerView
                
                if vm.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if !vm.showError {
                    contentView
                }
                Spacer()
            }
         
            SideMenuView(showSideMenu: $showSideMenu, onSelectMenu: onMenuSelection)
        }
        .task {
            if vm.newProducts.isEmpty {
                vm.fetchHomeData()
            }
        }
        .refreshable {
            vm.fetchHomeData()
        }
        .navigationDestination(isPresented: $showDetail, destination: {
            if let selectedProduct = selectedProduct {
                ProductDetailView(product: selectedProduct)
            }
        })
        .toolbarBackground(.hidden, for: .navigationBar)
        .alert(vm.error ?? "error_title", isPresented: $vm.showError) {
            Button("retry", role: .cancel) {
                vm.fetchHomeData()
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

extension HomeView {
    
    var headerView: some View {
        HStack {
            IconButtonView(iconName: "sidebar.left")
                .padding()
                .onTapGesture {
                    withAnimation(.spring(response: 0.2)) {
                        showSideMenu.toggle()
                    }
                }
            
            Spacer()
            
            Text("home")
                .foregroundColor(.white)
                .font(.headline)
            
            Spacer()
            
            IconButtonView(iconName: "cart.fill")
                .padding()
                .onTapGesture {
                    withAnimation(.spring(response: 0.2)) {
                        showCart.toggle()
                    }
                }
        }
        .frame(height: 50)
        .background(Color.accentColor)
    
    }
    
    var contentView: some View {
        ScrollView {
            
            BannerView(images: vm.banners)
            
            VStack {
                ProductSectionView(title: "home_section_new", products: $vm.newProducts, onItemTap: onProductTap)
                
                Spacer()
                
                ProductSectionView(title: "home_section_popular", products: $vm.newProducts, onItemTap: onProductTap)
            }
        }
    }
    
    func onMenuSelection(menu: SideMenu) {
        switch menu {
        case .order:
            showOrder.toggle()
            
        case .language:
            showLanguage.toggle()
            
        case .logout:
            showLogin.toggle()
        
        default: break
        }
    }
       
}
