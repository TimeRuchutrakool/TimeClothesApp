//
//  MainScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var selectedIndex = 0
    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeScreen()
                .onAppear() {
                    selectedIndex = 0
                }
                .tabItem {
                    Label("Home", systemImage: "house.circle.fill")
                }
                .tag(0)
            SearchScreen()
                .onAppear() {
                    selectedIndex = 1
                }
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                }
                .tag(1)
            WishListScreen()
                .onAppear() {
                    selectedIndex = 2
                }
                .tabItem {
                    Label("Wishlist", systemImage: "heart.circle.fill")
                }
                .tag(2)
            ProfileScreen()
                .onAppear() {
                    selectedIndex = 3
                }
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
                .tag(3)
        }
        
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
