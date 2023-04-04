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
    @Published var wishlists: [Product] = []
    @Published var cartItems: [CartItem] = []
    @Published var totalPrice: Double = 0.0
    @Published var orders: [Order] = []
  
    init(){
        getOrders()
    }
    
    func getProductByFilter(field: String,value: Any){
        DispatchQueue.main.async {
            
            self.webService.getProductByFilter(field: field, value: value) { products in
                self.products = products
                
            }
        }
    }
    
    func getCategories(){
        DispatchQueue.main.async {
            self.webService.getCategories { categories in
                self.categories = categories
            }
        }
    }
    
    func addWishList(productID: String){
        DispatchQueue.main.async {
            self.webService.addWishLists(productID: productID)
        }
    }
    
    func removeWishList(productID: String){
        DispatchQueue.main.async {
            self.webService.removeWishLists(productID: productID)
        }
    }
    
    func getWishLists(){
        DispatchQueue.main.async {
            self.webService.getWishListsItems { products in
                self.wishlists = products
            }
        }
    }
    
    func getCartItems(){
        DispatchQueue.main.async {
            self.webService.getCartItems { cartItems in
                self.cartItems = cartItems
            }
        }
    }
    func addProductToCart(productID: String,size: String){
        DispatchQueue.main.async {
            self.webService.addItemToCart(productID: productID, size: size)
        }
    }
    func removeProductToCart(productID: String,size: String){
        DispatchQueue.main.async {
            self.webService.removeItemToCart(productID: productID, size: size)
        }
    }
    func getTotalPrice(){
        DispatchQueue.main.async {
            self.webService.getCartItems { cartItems in
                for cartItem in cartItems{
                    self.totalPrice += cartItem.product.price*Double(cartItem.quantity)
                }
            }
        }
    }
    func addOrder(cartItems: [CartItem]){
        DispatchQueue.main.async {
            self.webService.addOrder(cartItems: cartItems)
            self.cartItems = []
            self.webService.removecartItemAfterAddOrder()
        }
    }
    
    func getOrders(){
        DispatchQueue.main.async {
            self.webService.getOrders { orders in
                self.orders = orders
            }
        }
    }
}
