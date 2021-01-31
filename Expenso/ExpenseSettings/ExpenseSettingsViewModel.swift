//
//  ExpenseSettingsViewModel.swift
//  Expenso
//
//  Created by Sameer Nawaz on 31/01/21.
//

import UIKit
import CoreData

class ExpenseSettingsViewModel: ObservableObject {
    
    var csvModelArr = [ExpenseCSVModel]()
    
    @Published var currency = String()
    @Published var alertMsg = String()
    @Published var showAlert = false
    
    init() {
        currency = UserDefaults.standard.string(forKey: UD_EXPENSE_CURRENCY) ?? ""
    }
    
    func saveCurrency(currency: String) {
        self.currency = currency
        UserDefaults.standard.set(currency, forKey: UD_EXPENSE_CURRENCY)
    }
    
    func exportTransactions(moc: NSManagedObjectContext) {
        let request = ExpenseCD.fetchRequest()
        var results: [ExpenseCD]
        do {
            results = try moc.fetch(request) as! [ExpenseCD]
            if results.count <= 0 {
                alertMsg = "No data to export"
                showAlert = true
            } else {
                for i in results {
                    let csvModel = ExpenseCSVModel()
                    csvModel.title = i.title ?? ""
                    csvModel.amount = "\(currency)\(i.amount)"
                    csvModel.transactionType = "\(i.type == TRANS_TYPE_INCOME ? "INCOME" : "EXPENSE")"
                    csvModel.tag = getTransTagTitle(transTag: i.tag ?? "")
                    csvModel.occuredOn = "\(getDateFormatter(date: i.occuredOn, format: "yyyy-mm-dd hh:mm a"))"
                    csvModel.note = i.note ?? ""
                    csvModelArr.append(csvModel)
                }
                creatCSV()
            }
        } catch { alertMsg = "\(error)"; showAlert = true }
    }
    
    func creatCSV() {
        
        let fileName = "Expense.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "Title,Amount,Type,Tag,Occured On,Note\n"
        
        for csvModel in csvModelArr {
            let row = "\"\(csvModel.title)\",\"\(csvModel.amount)\",\"\(csvModel.transactionType)\",\"\(csvModel.tag)\",\"\(csvModel.occuredOn)\",\"\(csvModel.note)\"\n"
            csvText.append(row)
        }
        
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            let av = UIActivityViewController(activityItems: [path!], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        } catch { alertMsg = "\(error)"; showAlert = true }
        
        print(path ?? "not found")
    }
}
