//
//  Webservice.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/31/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


struct Webservice{
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    
    func getUser(completion: @escaping (Customer) -> ()) {
        db.collection("Customers").document(auth.currentUser?.uid ?? "").getDocument { querySnapshot, error in
            if let error = error{
                print(error)
            }
            else{
                guard let snapshot = querySnapshot else{
                    return
                }
                if let data = snapshot.data(){
                    let user = Customer()
                    user.id = self.auth.currentUser?.uid ?? ""
                    user.username = data["username"] as? String ?? ""
                    user.email = data["email"] as? String ?? ""
                   
                    
                    completion(user)
                }
                
            }
        }
        
    }
    
   
    
    func getProductByFilter(field: String,value: Any,completion: @escaping ([Product]) -> ()){
        var products: [Product] = []
        var wishlists: [String] = []
        db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("wishlists").getDocuments { querySnapshot, error in
            if let error = error{
                print(error)
            }
            else{
                guard let snapshot = querySnapshot else{
                    return
                }
                for document in snapshot.documents{
                    let id = document.documentID
                    wishlists.append(id)
                }
                db.collection("Products").whereField(field, isEqualTo: value).getDocuments { querySnapshot, error in
                    if let error = error{
                        print(error)
                    }
                    else{
                        guard let snapshot = querySnapshot else{
                            return
                        }
                        for document in snapshot.documents{
                            let product = Product()
                            let id = document.documentID
                            product.id = id
                            product.productName = document["productname"] as? String ?? ""
                            product.price = document["price"] as? Double ?? 0
                            product.imageURL = document["imageURL"] as? String ?? ""
                            product.collection = document["collection"] as? String ?? ""
                            product.new = document["new"] as? Bool ?? false
                            product.category = document["category"] as? String ?? ""
                            
                            for wishlistID in wishlists{
                                if wishlistID == id{
                                    product.isWish = true
                                }
                            }
                            products.append(product)
                            
                        }
                        completion(products)
                    }
                }

            }
        }
        
    }
    
    func getCategories(completion: @escaping ([Categories])->()){
        var categories: [Categories] = []
        db.collection("Categories").getDocuments { querySnapshot, error in
            if let error = error{
                print(error)
            }
            else{
                guard let snapshot = querySnapshot else{
                    return
                }
                
                for document in snapshot.documents{
                    let category = Categories()
                    category.id = document.documentID
                    category.category = document["category"] as? String ?? ""
                    categories.append(category)
                }
                completion(categories)
            }
        }
    }
    
    func addWishLists(productID: String){
        
        db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("wishlists").document(productID).setData(["isWish": true], merge: true)
        
    }
    func removeWishLists(productID: String){
        
        db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("wishlists").document(productID).delete()
        
    }
}
