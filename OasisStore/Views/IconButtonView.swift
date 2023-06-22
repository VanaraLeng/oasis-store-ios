//
//  ButtonView.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import SwiftUI

struct IconButtonView: View {
    @State var iconName: String
    @State var title: String = ""
    @State var animate: Bool = false
    
    var onTap: (() -> Void)?
    
    var body: some View {
        HStack (spacing: 4) {
            Image(systemName: iconName)
                .font(.title2)
            
            if !title.isEmpty {
                Text(title)
                    .font(.callout)
                    .fontWeight(.medium)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .foregroundColor(.white)
        .background(Color.accentColor)
        .cornerRadius(25)
            
    }
}

struct IconButtonView_Previews: PreviewProvider {
    static var previews: some View {
        IconButtonView(iconName: "sun.min")
            .previewLayout(.sizeThatFits)
    }
}
