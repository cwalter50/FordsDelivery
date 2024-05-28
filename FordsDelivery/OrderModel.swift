//
//  OrderModel.swift
//  FordsDelivery
//
//  Created by Christopher Walter on 5/28/24.
//

import Foundation
import SwiftUI
import Firebase

class OrderModel: ObservableObject, Identifiable {
    var itemName: String
    var quantity: Int?
    var created: Date
    var id: String
    
    init(itemName: String, quantity: Int? = nil, created: Date = Date(), id: String = UUID().uuidString) {
        self.itemName = itemName
        self.quantity = quantity
        self.created = created
        self.id = id
    }
    
    init(data: [String: Any]) {
        itemName = data["itemName"] as? String ?? "No Item name found"
        quantity = data["quantity"] as? Int ?? 0
//        let foundCreated = data["created"] as? Timestamp ?? Timestamp()
        created = data["created"] as? Date ?? Date()
        id = data["id"] as? String ?? "NO ID FOUND"
    }
    
    func toDictionaryValues() -> [String: Any] {
        
        return [
            "itemName": itemName,
            "quantity": quantity ?? 0,
            "created": Timestamp(date: created),
            "id": id
        ]
    }
}
