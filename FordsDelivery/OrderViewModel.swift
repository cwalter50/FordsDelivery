//
//  OrderViewModel.swift
//  FordsDelivery
//
//  Created by Christopher Walter on 5/28/24.
//

import Foundation
import SwiftUI
import Firebase

class OrderViewModel: ObservableObject {
    
    @Published var orders: [OrderModel] = []
    
    let db = Firestore.firestore()
    
    func saveOrderToFirebase(order: OrderModel) {
        
        db.collection("orders").document("\(order.id)").setData(order.toDictionaryValues()) { 
            error in
            if let err = error {
                print(err)
            }
            else {
                print("Successfully added \(order.itemName) to database")
            }
        }
        
    }
    
    func loadOrdersFromFirebase() {
        db.collection("orders").getDocuments { snapshot, error in
            if let err = error {
                print(err)
                return
            }
            if let snap = snapshot {
                for item in snap.documents {
                    let found = OrderModel(data: item.data())
                    self.orders.append(found)
                }
            }
        }
    }
    
    func addOrderListenerToFirebase() {
        
        db.collection("orders").addSnapshotListener { [self]snapshot, error in
            if let err = error {
                print(err)
                return
            }
            orders.removeAll()
            if let snap = snapshot {
                for item in snap.documents {
                    let found = OrderModel(data: item.data())
                    orders.append(found)
                }
            }
        }
        
    }
}
