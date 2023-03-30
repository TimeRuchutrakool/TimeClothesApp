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
    
    let db = Firestore.firestore()
    @Published var newArrivalProduct: [Product] = []
    @Published var categories: [Categories] = []
    @Published var products: [Product] = []
    var wishlist: [String] = []
    
    
    func getNewArrivalProduct(){
        newArrivalProduct = []
        db.collection("Products").whereField("new", isEqualTo: true).getDocuments { querySnapshot, error in
            
            if let error = error{
                print(error)
            }
            else{
                guard let snapshot = querySnapshot else{
                    return
                }
                for document in snapshot.documents {
                    let data = document.data()
                    let product = Product()
                    product.id = document.documentID
                    product.productName = data["productname"] as? String ?? ""
                    product.price = data["price"] as? Double ?? 0
                    product.imageURL = data["imageURL"] as? String ?? ""
                    product.collection = data["collection"] as? String ?? ""
                    product.category = data["category"] as? String ?? ""
                    product.new = data["new"] as? Bool ?? false
                    
                    self.newArrivalProduct.append(product)
                }
            }
        }
    }
    
    func getWishList(){
        let auth = Auth.auth()
        db.collection("Customers").document(auth.currentUser?.uid ?? "").getDocument { querySnapshot, error in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                guard let snapshot = querySnapshot else{
                    return
                }
                if let data = snapshot.data()?["wishlist"] as? [String]{
                    
                   
                    self.wishlist = data
                    print(self.wishlist)
                }
            }
        }
    }
    
    func getProductByFilter(field: String,value: String){
        products = []
        db.collection("Products").whereField(field, isEqualTo: value).getDocuments { querySnapshot, error in
            if let error = error{
                print(error)
            }
            else{
                guard let snapshot = querySnapshot else{
                    return
                }
                for document in snapshot.documents{
                    let data = document.data()
                    let product = Product()
                    product.id = document.documentID
                    product.productName = data["productname"] as? String ?? ""
                    product.price = data["price"] as? Double ?? 0
                    product.imageURL = data["imageURL"] as? String ?? ""
                    product.collection = data["collection"] as? String ?? ""
                    product.category = data["category"] as? String ?? ""
                    product.new = data["new"] as? Bool ?? false
                    self.products.append(product)
                    
                }
            }
        }
    }
    
    
    func getCategories(){
        categories = []
        db.collection("Categories").getDocuments { querySnapshot, error in
            if let error = error{
                print(error)
            }
            else{
                guard let snapshot = querySnapshot else{
                    return
                }
                for document in snapshot.documents {
                    let data = document.data()
                    let category = Categories()
                    category.id = document.documentID
                    category.category = data["category"] as? String ?? ""
                    self.categories.append(category)
                }
                
            }
        }
    }
}
