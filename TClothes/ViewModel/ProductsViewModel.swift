//
//  ProductsViewModel.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ProductsViewModel: ObservableObject{
    
    let webService = Webservice()
    @Published var categories: [Categories] = []
    @Published var products: [Product] = []
    @Published var user: Customer = Customer()
    @Published var wishlists: [Product] = []
    @Published var cartItems: [CartItem] = []
    
    func getuser(){
        webService.getUser { user in
            self.user = user
           
        }
    }
    
    func getProductByFilter(field: String,value: Any){
        
            webService.getProductByFilter(field: field, value: value) { products in
                self.products = products
                
            }
        
    }
    
    func getCategories(){
        
            self.webService.getCategories { categories in
                self.categories = categories
            }
        
    }

    func addWishList(productID: String){
        
            self.webService.addWishLists(productID: productID)
        
    }

    func removeWishList(productID: String){
        
            self.webService.removeWishLists(productID: productID)
        
    }
    
    func getWishLists(){
        webService.getWishListsItems { products in
            self.wishlists = products
        }
    }
    
    func getCartItems(){
        webService.getCartItems { cartItems in
            self.cartItems = cartItems
        }
    }
}
