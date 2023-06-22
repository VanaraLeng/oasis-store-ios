//
//  Menu.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import Foundation

struct Menu: Identifiable {
    let id = UUID().uuidString
    let title: String
    let icon: String
    let style: MenuStyle
    
    enum MenuStyle {
        case normal
        case destructive
    }
    
    init(title: String, icon: String, style: MenuStyle = .normal) {
        self.title = title
        self.icon = icon
        self.style = style
    }
    
}
