//
//  OrderDetailView.swift
//  CoffeeThere
//
//  Created by Oguz Mert Beyoglu on 15.10.2024.
//

import SwiftUI

struct OrderDetailView: View {
    let orderId: Int
    @EnvironmentObject private var model: CoffeeModel
    @State private var isPresented: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    private func deleteOrder() async {
        do {
            try await model.deleteOrder(orderId)
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack() {
            if let order = model.orderById(orderId) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(order.coffeeName)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("coffeeNameText")
                    Text(order.size.rawValue)
                        .opacity(0.5)
                    Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                    
                    HStack {
                        Spacer()
                        Button("Edit") {
                            isPresented = true
                        }.accessibilityIdentifier("editOrderButton")
                        
                        Button("Delete", role: .destructive) {
                            Task {
                                await deleteOrder()
                            }
                        }
                        Spacer()
                    }
                }.sheet(isPresented: $isPresented) {
                    AddCoffeeView(order: order)
                }
            }
            Spacer()
            
        }.padding()
    }
}

#Preview {
    var config = Configuration()
    OrderDetailView(orderId: 2).environmentObject(CoffeeModel(webservice: WebService(baseURL: config.environment.baseURL)))
}
