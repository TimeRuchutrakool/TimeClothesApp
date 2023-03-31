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
    
    init(){
        getuser()
        
    }
    
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
        webService.getCategories { categories in
            self.categories = categories
        }
    }

    func addWishList(productID: String){
        webService.addWishLists(productID: productID)
    }

    func removeWishList(productID: String){
        webService.removeWishLists(productID: productID)
    }
}
