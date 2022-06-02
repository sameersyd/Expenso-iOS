//
//  MonthlyTransactionDetailedViewModel.swift
//  Expenso
//
//  Created by Hendrik Steen on 02.06.22.
//

import UIKit
import CoreData

class MonthlyTransactionDetailedViewModel: ObservableObject {
    
    @Published var monthlyTransactionObj: MonthlyExpenseCD
    
    @Published var alertMsg = String()
    @Published var showAlert = false
    @Published var closePresenter = false
    
    init(monthlyTransactionObj: MonthlyExpenseCD) {
        self.monthlyTransactionObj = monthlyTransactionObj
    }
    
    func deleteNote(managedObjectContext: NSManagedObjectContext) {
        managedObjectContext.delete(monthlyTransactionObj)
        do {
            try managedObjectContext.save(); closePresenter = true
        } catch { alertMsg = "\(error)"; showAlert = true }
    }
    
    func shareNote() {
        let shareStr = """
        Title: \(monthlyTransactionObj.title ?? "")
        Amount: \(UserDefaults.standard.string(forKey: UD_EXPENSE_CURRENCY) ?? "")\(monthlyTransactionObj.amount)
        monthlyTransactionObj        Category: \(getTransTagTitle(transTag: monthlyTransactionObj.tag ?? ""))
        Date to charge: \(getDateFormatter(date: monthlyTransactionObj.usingDate, format: "EEEE, dd MMM hh:mm a"))
        Note: \(monthlyTransactionObj.note ?? "")
        
        \(SHARED_FROM_EXPENSO)
        """
        let av = UIActivityViewController(activityItems: [shareStr], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}
