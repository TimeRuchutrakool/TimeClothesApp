//
//  WishListScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI

struct WishListScreen: View {
    
    let columns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    @ObservedObject private var productViewModel: ProductsViewModel
    
    init(){
        productViewModel = ProductsViewModel()
        productViewModel.getWishLists()
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("ColorSoftGray")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical,showsIndicators: false){
                    LazyVGrid(columns: columns) {
                        ForEach(productViewModel.wishlists) { product in
                            NavigationLink(destination: ProductDetailScreen(product: product)) {
                                ProductCard(product: product)
                                
                            }
                        }
                    }
                    
                }
                .refreshable {
                    productViewModel.getWishLists()
                }
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
