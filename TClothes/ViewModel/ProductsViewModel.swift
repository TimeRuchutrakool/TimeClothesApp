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
}
