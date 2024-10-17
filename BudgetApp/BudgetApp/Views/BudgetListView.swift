//
//  BudgetListView.swift
//  BudgetApp
//
//  Created by Oguz Mert Beyoglu on 16.10.2024.
//

import SwiftUI

struct BudgetListView: View {
    let budgetCategoryResuls: FetchedResults<BudgetCategory>
    let onDeleteBudgetCategory: (BudgetCategory) -> Void
    
    var body: some View {
        List {
            if !budgetCategoryResuls.isEmpty {
                ForEach(budgetCategoryResuls) { budgetCategory in
                    NavigationLink(value: budgetCategory) {
                        HStack {
                            Text(budgetCategory.title ?? "")
                            Spacer()
                            VStack(alignment: .trailing, spacing: 10) {
                                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                                Text("\(budgetCategory.overSpent ? "Overspent" : "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .fontWeight(.bold)
                                    .foregroundStyle(budgetCategory.overSpent ? .red : .green)
                            }
                            
                        }
                    }
                    
                }.onDelete { indexSet in
                    indexSet.map { budgetCategoryResuls[$0] }.forEach(onDeleteBudgetCategory)
                }
                
            } else {
                Text("No budget categories found.")
            }
        }.listStyle(.plain)
        .navigationDestination(for: BudgetCategory.self) { budgetCategory in
            BudgetDetailView(budgetCategory: budgetCategory)
        }
    }
}
