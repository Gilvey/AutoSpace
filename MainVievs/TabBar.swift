//
//  tabBar.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 17.04.24.
//

import SwiftUI

struct TabBar: View {
    var viewModel: MainTabBarViewModel
    
    @State private var isPresented = 0
    
    
    var body: some View {
        TabView(selection: $isPresented) {
            CatalogView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.dash")
                            .symbolEffect(.scale.up, isActive: isPresented == 0 ? true : false)
                        Text("Каталог")
                    }
                }.tag(0)
            
            CartView(viewModel: CartViewModel.shared)
                .tabItem {
                    VStack {
                        Image(systemName: "cart")
                            .symbolEffect(.scale.up, isActive: isPresented == 1 ? true : false)
                        Text("Корзина")
                    }
                }.tag(1)
            
            ProfileView(viewModel: ProfileViewModel(profile: MainUser(id: "", name: "Николай Гильвей", phone: 2967914, adress: "г. Минск, ул. Одоевского 87, кв. 28")))
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                            .symbolEffect(.scale.up, isActive: isPresented == 2 ? true : false)
                        Text("Профиль")
                    }
                }.tag(2)
        }
    }
}


