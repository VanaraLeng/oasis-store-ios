//
//  ProductDetailView.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/21/23.
//

import SwiftUI

struct ProductDetailView: View {
    @State var product: Product
    
    var body: some View {
        ScrollView {
            VStack {
                if let gallery = product.gallery {
                    BannerView(images: gallery)
                }
                
                VStack (alignment: .leading, spacing: 8) {
                    Text(product.name)
                        .font(.title)
                    
                    HStack {
                        Text(product.price.asCurrencyWith2Decimals())
                            .font(.title2)
                        
                        Spacer()
                        
                        IconButtonView(iconName: "cart", title: "detail_add_to_cart_button")
                            .onTapGesture {
                                // Add to cart
                            }
                    }
                    
                    Divider()
                        .padding(10)
                    
                    Text(product.description)
                        .font(.body)
                    
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .refreshable {
            
        }
        .navigationBarHidden(false)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: dev.products[0])
    }
}
