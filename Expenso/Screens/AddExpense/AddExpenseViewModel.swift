//
//  AddExpenseViewModel.swift
//  Expenso
//
//  Created by Sameer Nawaz on 31/01/21.
//

import UIKit
import CoreData

class AddExpenseViewModel: ObservableObject {
    
    var expenseObj: ExpenseCD?
    var monthlyTransactionObj: MonthlyTransactionCD?
    
    @Published var title = ""
    @Published var amount = ""
    @Published var occuredOn = Date()
    @Published var note = ""
    @Published var typeTitle = "Income"
    @Published var tagTitle = getTransTagTitle(transTag: TRANS_TAG_TRANSPORT)
    @Published var showTypeDrop = false
    @Published var showTagDrop = false
    
    @Published var selectedType = TRANS_TYPE_INCOME
    @Published var selectedTag = TRANS_TAG_TRANSPORT
    
    @Published var imageUpdated = false // When transaction edit, check if attachment is updated?
    @Published var imageAttached: UIImage? = nil
    
    @Published var alertMsg = String()
    @Published var showAlert = false
    @Published var closePresenter = false
    
    init(expenseObj: ExpenseCD? = nil, monthlyTransactionObj: MonthlyTransactionCD? = nil) {
        if monthlyTransactionObj != nil {
            
            self.monthlyTransactionObj = monthlyTransactionObj
            self.title = monthlyTransactionObj?.title ?? ""
            if let monthlyTransactionObj = monthlyTransactionObj {
                self.amount = String(monthlyTransactionObj.amount)
                self.typeTitle = monthlyTransactionObj.type == TRANS_TYPE_INCOME ? "Income" : "Expense"
            } else {
                self.amount = ""
                self.typeTitle = "Income"
            }
            self.occuredOn = monthlyTransactionObj?.usingDate ?? Date()
            self.note = monthlyTransactionObj?.note ?? ""
            self.tagTitle = getTransTagTitle(transTag: monthlyTransactionObj?.tag ?? TRANS_TAG_TRANSPORT)
            self.selectedType = monthlyTransactionObj?.type ?? TRANS_TYPE_INCOME
            self.selectedTag = monthlyTransactionObj?.tag ?? TRANS_TAG_TRANSPORT
            if let data = monthlyTransactionObj?.imageAttached {
                self.imageAttached = UIImage(data: data)
            }
            
            AttachmentHandler.shared.imagePickedBlock = { [weak self] image in
                self?.imageUpdated = true
                self?.imageAttached = image
            }
            
        } else {
            
            self.expenseObj = expenseObj
            self.title = expenseObj?.title ?? ""
            if let expenseObj = expenseObj {
                self.amount = String(expenseObj.amount)
                self.typeTitle = expenseObj.type == TRANS_TYPE_INCOME ? "Income" : "Expense"
            } else {
                self.amount = ""
                self.typeTitle = "Income"
            }
            self.occuredOn = expenseObj?.occuredOn ?? Date()
            self.note = expenseObj?.note ?? ""
            self.tagTitle = getTransTagTitle(transTag: expenseObj?.tag ?? TRANS_TAG_TRANSPORT)
            self.selectedType = expenseObj?.type ?? TRANS_TYPE_INCOME
            self.selectedTag = expenseObj?.tag ?? TRANS_TAG_TRANSPORT
            if let data = expenseObj?.imageAttached {
                self.imageAttached = UIImage(data: data)
            }
            
            AttachmentHandler.shared.imagePickedBlock = { [weak self] image in
                self?.imageUpdated = true
                self?.imageAttached = image
            }
            
        }
        
    }
    
    func getButtText() -> String {
        if selectedType == TRANS_TYPE_INCOME { return "\((expenseObj != nil || monthlyTransactionObj != nil) ? "EDIT" : "ADD") INCOME" }
        else if selectedType == TRANS_TYPE_EXPENSE { return "\((expenseObj != nil || monthlyTransactionObj != nil) ? "EDIT" : "ADD") EXPENSE" }
        else { return "\((expenseObj != nil || monthlyTransactionObj != nil) ? "EDIT" : "ADD") TRANSACTION" }
    }
    
    func attachImage() { AttachmentHandler.shared.showAttachmentActionSheet() }
    
    func removeImage() { imageAttached = nil }
    
    func saveTransaction(managedObjectContext: NSManagedObjectContext) {
        
        let expense: ExpenseCD
        let titleStr = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let amountStr = amount.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if titleStr.isEmpty || titleStr == "" {
            alertMsg = "Enter Title"; showAlert = true
            return
        }
        if amountStr.isEmpty || amountStr == "" {
            alertMsg = "Enter Amount"; showAlert = true
            return
        }
        guard let amount = Double(amountStr) else {
            alertMsg = "Enter valid number"; showAlert = true
            return
        }
        guard amount >= 0 else {
            alertMsg = "Amount can't be negative"; showAlert = true
            return
        }
        guard amount <= 1000000000 else {
            alertMsg = "Enter a smaller amount"; showAlert = true
            return
        }
        
        if expenseObj != nil {
            
            expense = expenseObj!
            
            if let image = imageAttached {
                if imageUpdated {
                    if let _ = expense.imageAttached {
                        // Delete Previous Image from CoreData
                    }
                    expense.imageAttached = image.jpegData(compressionQuality: 1.0)
                }
            } else {
                if let _ = expense.imageAttached {
                    // Delete Previous Image from CoreData
                }
                expense.imageAttached = nil
            }
            
        } else {
            expense = ExpenseCD(context: managedObjectContext)
            expense.createdAt = Date()
            if let image = imageAttached {
                expense.imageAttached = image.jpegData(compressionQuality: 1.0)
            }
        }
        expense.updatedAt = Date()
        expense.type = selectedType
        expense.title = titleStr
        expense.tag = selectedTag
        expense.occuredOn = occuredOn
        expense.note = note
        expense.amount = amount
        do {
            try managedObjectContext.save()
            closePresenter = true
        } catch { alertMsg = "\(error)"; showAlert = true }
    }
    
    func deleteTransaction(managedObjectContext: NSManagedObjectContext) {
        guard let expenseObj = expenseObj else { return }
        managedObjectContext.delete(expenseObj)
        do {
            try managedObjectContext.save(); closePresenter = true
        } catch { alertMsg = "\(error)"; showAlert = true }
    }
    
    
    func saveMonthlyTransaction(managedObjectContext: NSManagedObjectContext) {
        let expense: MonthlyTransactionCD
        let titleStr = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let amountStr = amount.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if titleStr.isEmpty || titleStr == "" {
            alertMsg = "Enter Title"; showAlert = true
            return
        }
        if amountStr.isEmpty || amountStr == "" {
            alertMsg = "Enter Amount"; showAlert = true
            return
        }
        guard let amount = Double(amountStr) else {
            alertMsg = "Enter valid number"; showAlert = true
            return
        }
        guard amount >= 0 else {
            alertMsg = "Amount can't be negative"; showAlert = true
            return
        }
        guard amount <= 1000000000 else {
            alertMsg = "Enter a smaller amount"; showAlert = true
            return
        }
        
        if monthlyTransactionObj != nil {
            
            expense = monthlyTransactionObj!
            
//            if let image = imageAttached {
//                if imageUpdated {
//                    if let _ = expense.imageAttached {
//                        // Delete Previous Image from CoreData
//                    }
//                    expense.imageAttached = image.jpegData(compressionQuality: 1.0)
//                }
//            } else {
//                if let _ = expense.imageAttached {
//                    // Delete Previous Image from CoreData
//                }
//                expense.imageAttached = nil
//            }
            
        } else {
            expense = MonthlyTransactionCD(context: managedObjectContext)
//            if let image = imageAttached {
//                expense.imageAttached = image.jpegData(compressionQuality: 1.0)
//            }
        }
        expense.usingDate = occuredOn
        expense.type = selectedType
        expense.title = titleStr
        expense.tag = selectedTag
        expense.note = note
        expense.amount = amount
        do {
            try managedObjectContext.save()
            closePresenter = true
        } catch { alertMsg = "\(error)"; showAlert = true }
    }
    
    func deleteMonthlyTransaction(managedObjectContext: NSManagedObjectContext) {
        guard let monthlyTransactionObj = monthlyTransactionObj else { return }
        managedObjectContext.delete(monthlyTransactionObj)
        do {
            try managedObjectContext.save(); closePresenter = true
        } catch { alertMsg = "\(error)"; showAlert = true }
    }
    
    func checkAllMonthlyExpenses(managedObjectContext: NSManagedObjectContext, request: NSFetchRequest<MonthlyTransactionCD>) {
        do {
            let allMonthlyExpenses = try? managedObjectContext.fetch(request)
            if allMonthlyExpenses == nil {
                print("error")
                return
            }
            for expense in allMonthlyExpenses! {
                print(expense.usingDate ?? Date())
                if expense.usingDate == nil {
                    continue
                }
                if Calendar.current.isDateInToday(expense.usingDate!) || Date() > expense.usingDate! {
                    if let date = Calendar.current.date(byAdding: .month, value: 1, to: expense.usingDate!) {
                        expense.usingDate = date
                        print("date used")
                        let newExpense = ExpenseCD(context: managedObjectContext)
                        newExpense.amount = expense.amount
                        newExpense.createdAt = Date()
                        //newExpense.imageAttached = expense.imageAttached
                        newExpense.note = expense.note
                        newExpense.occuredOn = Date()
                        newExpense.tag = expense.tag
                        newExpense.title = expense.title
                        newExpense.type = expense.type
                        newExpense.updatedAt = Date()
                        try managedObjectContext.save()
                    }
                } else {
                    print("not current date or later date")
                }
            }
        } catch {
            print(error)
        }
    }
    
}
