//
//  BudgetDetailView.swift
//  BudgetApp
//
//  Created by Oguz Mert Beyoglu on 16.10.2024.
//

import SwiftUI
import CoreData

struct BudgetDetailView: View {
    let budgetCategory: BudgetCategory
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var title: String = ""
    @State private var total: String = ""
    
    var isFormValid: Bool {
        guard let totalAsDouble = Double(total) else { return false}
        return !title.isEmpty && !total.isEmpty && totalAsDouble > 0
    }
    
    private func saveTransaction() {
        do {
            let transaction = Transaction(context: viewContext)
            transaction.title = title
            transaction.total = Double(total)!
            
            budgetCategory.addToTransactions(transaction)
            
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private func deleteTransaction(_ transaction: Transaction) {
        viewContext.delete(transaction)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(budgetCategory.title ?? "")
                        .font(.largeTitle)
                    HStack {
                        Text("Budget:")
                        Text("\(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)")
                    }.fontWeight(.bold)
                }.padding()
            }
            
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Total", text: $total)
                } header: {
                    Text("Add Transaction")
                }
                
                HStack {
                    Spacer()
                    Button("Save Transaction") {
                        saveTransaction()
                    }.disabled(!isFormValid)
                    Spacer()
                }
                
            }
            
            // display summary of budget category
            BudgetSummaryView(budgetCategory: budgetCategory)
            
            TransactionListView(request:BudgetCategory.transactionByCategoryRequest(budgetCategory), onDeleteTransaction: deleteTransaction)
            
            Spacer()
        }
    }
}

#Preview {
    BudgetDetailView(budgetCategory: BudgetCategory())
        .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
}
