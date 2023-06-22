//
//  HeaderView.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import SwiftUI

protocol HeaderViewDelegate {
    func onLeftButtonPress()
    func onRightButtonPress()
}

struct HeaderView: View {
    
    @State var title = ""
    @State var leftIconName = ""
    @State var rightIconName = ""
    
    var delegate: HeaderViewDelegate?
    
    var body: some View {
        HStack {
            IconButtonView(iconName: leftIconName)
                .padding()
                .onTapGesture {
                    delegate?.onLeftButtonPress()
                }
            
            Spacer()
            
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
            
            Spacer()
            
            IconButtonView(iconName: rightIconName)
                .padding()
                .onTapGesture {
                    delegate?.onRightButtonPress()
                }
        }
        .frame(height: 50)
        .background(Color.accentColor)
    
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(delegate: nil)
            .previewLayout(.sizeThatFits)
    }
}
