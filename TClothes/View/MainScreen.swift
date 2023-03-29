//
//  MainScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Label("Home", systemImage: "house.circle.fill")
                }
            SearchScreen()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                }
            WishListScreen()
                .tabItem {
                    Label("Wishlist", systemImage: "heart.circle.fill")
                }
            ProfileScreen()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
        }
        
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
