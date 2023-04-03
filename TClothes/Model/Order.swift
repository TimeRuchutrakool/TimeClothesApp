//
//  Order.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 4/3/23.
//

import Foundation

class Order: Identifiable{
    
    var orderID: String = ""
    var date: Date = Date()
    var items: [Item] = [Item]()
    
    var dateString: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    var totalPrice: String{
        var total = 0.0
        for item in items{
            total += item.price*Double(item.quantity)
        }
        return String(format: "$%.2f", total)
    }
    
}

class Item: Identifiable{
    var productID: String = ""
    var productName: String = ""
    var size: String = ""
    var quantity: Int = 0
    var imageURL: String = ""
    var price: Double = 0.0
    
    var priceString: String{
        return String(format: "$%.2f", price*Double(quantity))
    }
}
