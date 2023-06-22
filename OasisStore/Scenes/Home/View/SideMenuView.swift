//
//  SideMenuView.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var showSideMenu: Bool
    
    
    @State private var menu = [
        Menu(title: "Home", icon: "house"),
        Menu(title: "Order", icon: "cart"),
        Menu(title: "Logout", icon: "rectangle.portrait.and.arrow.right", style: .destructive),
    ]
    
    private let title = "Oasis Store"
    private let footer = "Vanara Leng 2023"
    private let animationDuration = 0.3
    
    var body: some View {
        ZStack (alignment: .leading) {
            if showSideMenu {
                chromeView
                sideMenu
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(showSideMenu: .constant(true))
    }
}

extension SideMenuView {
    
    fileprivate var chromeView: some View {
        Color.black.opacity(0.8)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                withAnimation(.spring(response: animationDuration)) {
                    showSideMenu.toggle()
                }
            }
            .transition(.opacity)
    }
    
    fileprivate var sideMenu: some View {
        VStack {
            // Title
            Text(title)
                .font(.headline)
                .padding(.top, 10)
                .padding(.bottom, 0)
            
            // Menu here
            VStack {
                ForEach(menu) { menu in
                    MenuItemView(menu: menu)
                        .onTapGesture {
                            withAnimation(.spring(response: animationDuration)) {
                                showSideMenu = false
                            }
                        }
                }
            }
            
            Spacer()
            
            Text (footer)
                .font(.footnote)
                .foregroundColor(.accentColor)
        }
        .background(
            Color.backgroundColor
                .ignoresSafeArea()
                .shadow(color: .shadowColor, radius: 5)
        )
        .frame(width: 300)
        .transition(.move(edge: showSideMenu ? .leading : .trailing))
    }
}
