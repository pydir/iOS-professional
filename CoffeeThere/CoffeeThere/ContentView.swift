//
//  ContentView.swift
//  CoffeeThere
//
//  Created by Oguz Mert Beyoglu on 15.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: CoffeeModel
    
    private func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    private func deleteOrder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let order = model.orders[index]
            
            guard let orderId = order.id else {
                return
            }
            Task {
                do {
                    try await model.deleteOrder(orderId)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if model.orders.isEmpty {
                    Text("No orders found!").accessibilityIdentifier("noOrdersText")
                } else {
                    List {
                        ForEach(model.orders) { order in
                            NavigationLink(value: order.id) {
                                OrderCellView(order: order)
                            }
                        }.onDelete(perform: deleteOrder)
                    }
                }
            }
            .navigationDestination(for: Int.self, destination: { orderID in
                OrderDetailView(orderId: orderID)
            })
            .task {
                await populateOrders()
            }.sheet(isPresented: $isPresented, content: {
                AddCoffeeView()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add New Order") {
                        isPresented = true
                    }.accessibilityIdentifier("addNewOrderButton")
                }
            }
        }
    }
}

#Preview {
    var config = Configuration()
    ContentView().environmentObject(CoffeeModel(webservice: WebService(baseURL: config.environment.baseURL)))
}


