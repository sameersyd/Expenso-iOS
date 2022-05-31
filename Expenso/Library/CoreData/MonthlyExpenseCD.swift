//
//  MonthlyExpenseCD.swift
//  Expenso
//
//  Created by Hendrik Steen on 31.05.22.
//

import Foundation
import CoreData

public class MonthlyExpenseCD: NSManagedObject, Identifiable {
    @NSManaged public var type: String?
    @NSManaged public var title: String?
    @NSManaged public var tag: String?
    @NSManaged public var note: String?
    @NSManaged public var amount: Double
    @NSManaged public var imageAttached: Data?
    @NSManaged public var usingDate: Date?
}

extension MonthlyExpenseCD {
    static func getallDates(context: NSManagedObjectContext) {
        let request: NSFetchRequest<MonthlyExpenseCD> = MonthlyExpenseCD.fetchRequest() as! NSFetchRequest<MonthlyExpenseCD>
        request.sortDescriptors = []
        let allMonthlyExpenses = try! context.fetch(request)
        for expense in allMonthlyExpenses {
            print(expense.usingDate ?? Date())
        }
    }
}
