//
//  WishListScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI

struct WishListScreen: View {
    
    let columns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("ColorSoftGray")
                    .edgesIgnoringSafeArea(.all)
                
            }
            .navigationTitle("Wishlists")
        }
    }
}

struct WishListScreen_Previews: PreviewProvider {
    static var previews: some View {
        WishListScreen()
    }
}
