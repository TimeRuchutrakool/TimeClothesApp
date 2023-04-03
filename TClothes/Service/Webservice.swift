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
        var cartItemsID: [String:(String,String,Int)] = [:]
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
                    cartItemsID[id] = (document["productID"] as? String ?? "",document["size"] as? String ?? "",document["quantity"] as? Int ?? 0)
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
                                if value.0 == id{
                                    let product = Product()
                                    
                                    let size = value.1
                                    let quantity = value.2
                                    product.id = id
                                    product.productName = document["productname"] as? String ?? ""
                                    product.price = document["price"] as? Double ?? 0
                                    product.imageURL = document["imageURL"] as? String ?? ""
                                    let cartItem = CartItem()
                                    cartItem.cartItemID = key
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
    func addItemToCart(productID: String,size: String){
        db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("cartItems").getDocuments { querySnapshot, error in
            if let error = error{
                print(error)
            }
            else{
                guard let snapshot = querySnapshot else {
                    return
                }
                if snapshot.documents.isEmpty{
                    db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("cartItems").document(productID+size).setData([
                        "productID" : productID,
                        "quantity" : 1,
                        "size" : size
                    ])
                }
                else{
                    for document in snapshot.documents{
                        if document.documentID == (productID+size){
                            var quantity = document["quantity"] as? Double ?? 0
                            quantity += 1
                            db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("cartItems").document(productID+size).setData([
                                "quantity": quantity
                            ],merge: true)
                        }
                        else{
                            db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("cartItems").document(productID+size).setData([
                                "productID" : productID,
                                "quantity" : 1,
                                "size" : size
                            ])
                        }
                    }
                }
            }
        }
    }
    //MARK: - REMOVE CART ITEM
    func removeItemToCart(productID: String,size: String){
        db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("cartItems").getDocuments { querySnapshot, error in
            if let error = error{
                print(error)
            }
            else{
                guard let snapshot = querySnapshot else {
                    return
                }
                for document in snapshot.documents{
                    if document.documentID == (productID+size){
                        var quantity = document["quantity"] as? Double ?? 0
                        quantity -= 1
                        if quantity > 0{
                            
                            db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("cartItems").document(productID+size).setData([
                                "quantity": quantity
                            ],merge: true)
                        }
                        else{
                            db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("cartItems").document(productID+size).delete()
                        }
                    }
                    
                }
            }
        }
    }
    
    //MARK: - Add Orders
    func addOrder(cartItems: [CartItem]){
        var items: [String:[String:Any]] = [:]
        for item in cartItems{
            items[item.cartItemID] = [
                "productID" : item.product.id,
                "productname" : item.product.productName,
                "price" : item.product.price,
                "quantity" : item.quantity,
                "size" : item.size,
                "imageURL" : item.product.imageURL
            ]
        }
        db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("orders").document().setData([
            "date" : Date(),
            "items" : items
        ])
        db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("cartItems").document().delete()
        
    }
    
    //MARK: - Get Order
    func getOrders(completion: @escaping ([Order]) -> ()) {
        var orders: [Order] = []
        
        db.collection("Customers").document(auth.currentUser?.uid ?? "").collection("orders").getDocuments(){ querySnapshot,error in
            if let error = error{
                print(error)
            }
            else{
                guard let snapshot = querySnapshot else{
                    return
                }
                
                for document in snapshot.documents{
                    let order: Order = Order()
                    let orderID = document.documentID
                    let date = document["date"] as? Date ?? Date()
                    var orderItems: [Item] = []
                    let items = document["items"] as? [String:[String:Any]]
                    guard let items = items else{
                        return
                    }
                    for id in items.keys{
                        let item = Item()
                        let productID = items[id]?["productID"] as? String ?? ""
                        let productName = items[id]?["productname"] as? String ?? ""
                        let size = items[id]?["size"] as? String ?? ""
                        let quantity = items[id]?["quantity"] as? Int ?? 0
                        let imageURL = items[id]?["imageURL"] as? String ?? ""
                        let price = items[id]?["price"] as? Double ?? 0.0
                        item.productID = productID
                        item.productName = productName
                        item.quantity = quantity
                        item.size = size
                        item.imageURL = imageURL
                        item.price = price
                        orderItems.append(item)
                    }
                    order.orderID = orderID
                    order.date = date
                    order.items = orderItems
                    orders.append(order)
                }
                completion(orders)
            }
        }
        
    }
}
