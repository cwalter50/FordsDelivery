//
//  ContentView.swift
//  FordsDelivery
//
//  Created by Christopher Walter on 5/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm: OrderViewModel = OrderViewModel()
    
    @State var name: String = ""
    @State var quantity: Int?
    
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter item name", text: $name)
                TextField("Enter item quantity", value: $quantity, format: .number)
                Button("+") {
                    let newOrder = OrderModel(itemName: name, quantity: quantity ?? 1)
                    vm.saveOrderToFirebase(order: newOrder)
                    name = ""
                    quantity = nil
                }
                .disabled(name == "")
                .font(.largeTitle)
            }
            .textFieldStyle(.roundedBorder)
            Divider()
            List {
                ForEach(vm.orders) {
                    order in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "\(order.quantity ?? 1).circle")
                                .foregroundStyle(Color.secondary)
                            Text(order.itemName)
                                .font(.title)
                            
                        }
                        Text("\(order.created.formatted())")
                            .foregroundStyle(.secondary)
                            .italic()
                            .font(.caption)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            vm.addOrderListenerToFirebase()
        }
    }
}

#Preview {
    ContentView()
}
