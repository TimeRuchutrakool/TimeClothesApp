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
    
    //MARK: -  GET USER
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
    
    
    //MARK: - GET PRODUCT
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
    
    //MARK: - GET CATEGORY
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
    
    //MARK: - ADD WISHLIST
    func addWishLists(productID: String){
        
        db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("wishlists").document(productID).setData(["isWish": true], merge: true)
        
    }
    
    //MARK: - REMOVE WISHLIST
    func removeWishLists(productID: String){
        
        db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("wishlists").document(productID).delete()
        
    }
    
    //MARK: - GET WISHLISTS
    func getWishListsItems(completion: @escaping ([Product]) -> ()){
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
                db.collection("Products").getDocuments { querySnapshot, error in
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
                            if product.isWish{
                                products.append(product)
                            }
                        }
                        completion(products)
                    }
                }
                
            }
        }
    }
    
    //MARK: - GET CART ITEMS
    func getCartItems(completion: @escaping ([CartItem]) -> ()){
        var cartItems: [CartItem] = []
        var cartItemsID: [String:(String,Int)] = [:]
        db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("cartItems").getDocuments { querySnapshot, error in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                guard let snapShot = querySnapshot else{
                    return
                }
                let documents = snapShot.documents
                for document in documents{
                    let id = document.documentID
                    cartItemsID[id] = (document["size"] as? String ?? "",document["quantity"] as? Int ?? 0)
                }
                db.collection("Products").getDocuments { querySnapshot, error in
                    if let error = error{
                        print(error)
                    }
                    else{
                        guard let snapshot = querySnapshot else{
                            return
                        }
                        for document in snapshot.documents{
                            let id = document.documentID
                            for (key,value) in cartItemsID{
                                if key == id{
                                    let product = Product()
                                    
                                    let size = value.0
                                    let quantity = value.1
                                    product.id = id
                                    product.productName = document["productname"] as? String ?? ""
                                    product.price = document["price"] as? Double ?? 0
                                    product.imageURL = document["imageURL"] as? String ?? ""
                                    let cartItem = CartItem()
                                    cartItem.product = product
                                    cartItem.size = size
                                    cartItem.quantity = quantity
                                    cartItems.append(cartItem)
                                }
                            }
                            
                           
                        }
                        completion(cartItems)
                    }
                }
            }
        }
    }
    
    //MARK: - ADD CART ITEM
    //MARK: - REMOVE CART ITEM
    
}
