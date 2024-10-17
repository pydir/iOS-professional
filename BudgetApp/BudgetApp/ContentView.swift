//
//  ContentView.swift
//  BudgetApp
//
//  Created by Oguz Mert Beyoglu on 16.10.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    @State private var isPresented = false
    
    var total: Double {
        budgetCategoryResults.reduce(0) { result, budgetCategory in
            return result + budgetCategory.total
        }
    }
    
    private func deleteBudgetCategory(budgetCategory: BudgetCategory) {
        viewContext.delete(budgetCategory)
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
     
    var body: some View {
        NavigationStack {
            VStack(alignment: .trailing) {
                Text("Total: \(total as NSNumber, formatter: NumberFormatter.currency)")
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                BudgetListView(budgetCategoryResuls: budgetCategoryResults,
                               onDeleteBudgetCategory: deleteBudgetCategory)
            }
            .sheet(isPresented: $isPresented, content: {
                AddBudgetCategoryView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Category") {
                        isPresented = true
                    }
                }
            }
        }
    } }
 
#Preview(traits: .sizeThatFitsLayout) {
    ContentView()
        .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
}
