//
//  TransactionListView.swift
//  BudgetApp
//
//  Created by Oguz Mert Beyoglu on 16.10.2024.
//

import SwiftUI
import CoreData

struct TransactionListView: View {
    @FetchRequest var transactions: FetchedResults<Transaction>
    let onDeleteTransaction: (Transaction) -> Void
    
    init(request: NSFetchRequest<Transaction>, onDeleteTransaction: @escaping (Transaction) -> Void) {
        _transactions = FetchRequest(fetchRequest: request)
        self.onDeleteTransaction = onDeleteTransaction
    }
    
    
    
    var body: some View {
        if transactions.isEmpty {
            Text("No transactions exist.")
        } else {
            List {
                ForEach(transactions) { transaction in
                    HStack {
                        Text(transaction.title ?? "")
                        Spacer()
                        Text("\(transaction.total as NSNumber, formatter: NumberFormatter.currency)")
                    }
                    
                }.onDelete { offsets in
                    offsets.map { transactions[$0] }.forEach(onDeleteTransaction)
                }
            }
        }
    }
}
