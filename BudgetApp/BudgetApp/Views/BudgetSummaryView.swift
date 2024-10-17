//
//  BudgetSummaryView.swift
//  BudgetApp
//
//  Created by Oguz Mert Beyoglu on 16.10.2024.
//

import SwiftUI

struct BudgetSummaryView: View {
    
    @ObservedObject var budgetCategory: BudgetCategory
    
    var body: some View {
        VStack {
            Text("\(budgetCategory.overSpent ? "Overspent" : "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
                .foregroundStyle(budgetCategory.overSpent ? .red : .green)
        }
    }
}
