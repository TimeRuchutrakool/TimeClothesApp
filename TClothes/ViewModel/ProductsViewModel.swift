//
//  ProductsViewModel.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import Foundation
import FirebaseFirestore

class ProductsViewModel: ObservableObject{
    
    let db = Firestore.firestore()
    @Published var newArrivalProduct: [Product] = []
    
    func getNewArrivalProduct(){
        db.collection("Products").whereField("new", isEqualTo: true).getDocuments { querySnapshot, error in
            
            if let error = error{
                print(error)
            }
            else{
                for document in querySnapshot!.documents {
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
    
}
