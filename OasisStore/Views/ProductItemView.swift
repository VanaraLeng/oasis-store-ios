//
//  ProductItemView.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import SwiftUI

struct ProductItemView: View {
    @State var product: Product
    
    var body: some View {
        
        VStack {
            AsyncImage(
                url: URL(string: product.imageUrl),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
      
                },
                placeholder: {
                    ProgressView()
                }
            )
            .frame(maxWidth: .infinity, minHeight: 120, maxHeight: 120)
            .clipped()
            
            VStack(spacing: 8) {
                HStack (spacing: 4) {
                    Text(product.price.asCurrencyWith2Decimals())
                        .font(.title3)
                    
                    if (product.discount > 0) {
                        Text(product.discount.asPercentage() + " off")
                        .font(.subheadline)
                            .foregroundColor(Color.red)
                    }
                }
                
                Text(product.name)
                    .setProductTitleFont()
                    .lineLimit(2)
                    .foregroundColor(.textColor)
                
                Text(product.description)
                    .productSubtitleFont()
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.disableTextColor)
                    
            }
            .padding(8)
        }
        .background(.background)
        .cornerRadius(6)
        .shadow(color: Color.shadowColor, radius: 2)
        .frame(minHeight: 150)
        .padding(12)
 
    }
}

struct ProductItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductItemView(product: dev.products[0])
            .previewLayout(.sizeThatFits)
    }
}
