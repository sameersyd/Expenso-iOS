//
//  MonthlyExpenseCD.swift
//  Expenso
//
//  Created by Hendrik Steen on 31.05.22.
//

import Foundation
import CoreData

public class MonthlyTransactionCD: NSManagedObject, Identifiable {
    @NSManaged public var type: String?
    @NSManaged public var title: String?
    @NSManaged public var tag: String?
    @NSManaged public var note: String?
    @NSManaged public var amount: Double
    @NSManaged public var imageAttached: Data?
    @NSManaged public var usingDate: Date?
}

extension MonthlyTransactionCD {
    static func getAllMonthlyExpenseData() -> NSFetchRequest<MonthlyTransactionCD> {
        let request: NSFetchRequest<MonthlyTransactionCD> = MonthlyTransactionCD.fetchRequest() as! NSFetchRequest<MonthlyTransactionCD>
        request.sortDescriptors = []
        return request
    }
}
