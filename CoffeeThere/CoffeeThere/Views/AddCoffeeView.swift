//
//  AddCoffeeView.swift
//  CoffeeThere
//
//  Created by Oguz Mert Beyoglu on 15.10.2024.
//

import SwiftUI

struct AddCoffeeErrors {
    var name: String        = ""
    var coffeeName: String  = ""
    var price: String       = ""
    
}

struct AddCoffeeView: View {
    var order: Order? = nil
    @State private var name: String             = ""
    @State private var coffeeName: String       = ""
    @State private var price: String            = ""
    @State private var coffeeSize: CoffeeSize   = .medium
    @State private var errors: AddCoffeeErrors  = AddCoffeeErrors()
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var model: CoffeeModel
    
    /// A Boolean value indicating whether a string has no characters.
    /// It's not a business role. This is UI validation.
    /// Think like requried keyword at HTML
    var isValid: Bool {
        errors = AddCoffeeErrors()
        
        if name.isEmpty {
            errors.name = "Name field cannot be empty!"
        }
        
        if coffeeName.isEmpty {
            errors.coffeeName   = "Coffee name cannot be empty!"
        }
        
        if price.isEmpty {
            errors.price = "Price cannot be empty!"
        } else if (!price.isNumeric) {
            errors.price = "Price needs to be a number!"
        } else if (price.isLessThan(1)) {
            errors.price = "Price needs to be more than zero!"
        }
        
        return errors.name.isEmpty && errors.price.isEmpty && errors.coffeeName.isEmpty
    }
    
    private func placeOrder(_ order: Order) async {
        do {
            try await model.placeOrder(order)
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private func updateOrder(_ order: Order) async {
        do {
            try await model.updateOrder(order)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func populateExistingOrder() {
        if let order = order {
            name = order.name
            coffeeName = order.coffeeName
            price = String(order.total)
            coffeeSize = order.size
        }
    }
    
    private func saveOrUpdate() async {
        if let order {
            var editOrder = order
            editOrder.name = name
            editOrder.total = Double(price) ?? 0.0
            editOrder.coffeeName = coffeeName
            editOrder.size = coffeeSize
            await updateOrder(editOrder)
        } else {
            let order = Order(name: name, coffeeName: coffeeName, total: Double(price) ?? 0.0 , size: coffeeSize)
            await placeOrder(order)
        }
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .accessibilityIdentifier("name")
                Text(errors.name).visible(errors.name.isNotEmpty)
                    .font(.caption)
                
                TextField("Coffee Name", text: $coffeeName)
                    .accessibilityIdentifier("coffeeName")
                Text(errors.coffeeName).visible(errors.coffeeName.isNotEmpty)
                    .font(.caption)
                
                TextField("Price", text: $price)
                    .accessibilityIdentifier("price")
                Text(errors.price).visible(errors.price.isNotEmpty)
                    .font(.caption)
                
                Picker("Select size", selection: $coffeeSize) {
                    ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                        Text(size.rawValue).tag(size)
                    }
                }.pickerStyle(.segmented)
                
                Button(order != nil ? "Update" : "Place order") {
                    
                    if isValid {
                        Task {
                            await saveOrUpdate()
                        }
                    }
                    
                }.accessibilityIdentifier("placeOrderButton")
                    .centerHorizontally()
                
            }.navigationTitle(order != nil ? "Update Order" : "Add Order")
                .onAppear {
                    populateExistingOrder()
                }
        }
    }
}

#Preview {
    AddCoffeeView()
}
