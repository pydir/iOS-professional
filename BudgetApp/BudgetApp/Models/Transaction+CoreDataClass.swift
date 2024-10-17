//
//  Transaction+CoreDataClass.swift
//  BudgetApp
//
//  Created by Oguz Mert Beyoglu on 16.10.2024.
//

import Foundation
import CoreData

@objc(Transaction )
public class Transaction: NSManagedObject {
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
}

