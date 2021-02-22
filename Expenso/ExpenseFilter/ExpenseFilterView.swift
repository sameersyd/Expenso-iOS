//
//  ExpenseFilterView.swift
//  Expenso
//
//  Created by Sameer Nawaz on 31/01/21.
//

import SwiftUI

struct ExpenseFilterView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ExpenseCD.getAllExpenseData(sortBy: ExpenseCDSort.occuredOn, ascending: false)) var expense: FetchedResults<ExpenseCD>
    
    @State var filter: ExpenseCDFilterTime = .all
    @State var showingSheet = false
    var isIncome: Bool?
    var categTag: String?
    
    init(isIncome: Bool? = nil, categTag: String? = nil) {
        self.isIncome = isIncome
        self.categTag = categTag
    }
    
    func getToolbarTitle() -> String {
        if let isIncome = isIncome {
            return isIncome ? "Income" : "Expense"
        } else if let tag = categTag { return getTransTagTitle(transTag: tag) }
        return "Dashboard"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                
                VStack {
                    ToolbarModelView(title: getToolbarTitle(), button1Icon: IMAGE_FILTER_ICON) { self.presentationMode.wrappedValue.dismiss() }
                        button1Method: { self.showingSheet = true }
                        .actionSheet(isPresented: $showingSheet) {
                            ActionSheet(title: Text("Select a filter"), buttons: [
                                    .default(Text("Overall")) { filter = .all },
                                    .default(Text("Last 7 days")) { filter = .week },
                                    .default(Text("Last 30 days")) { filter = .month },
                                    .cancel()
                            ])
                        }
                    
                    ScrollView(showsIndicators: false) {
                        if let isIncome = isIncome {
                            ExpenseFilterChartView(isIncome: isIncome, filter: filter).frame(width: 350, height: 350)
                            ExpenseFilterTransList(isIncome: isIncome, filter: filter)
                        }
                        if let tag = categTag {
                            HStack(spacing: 8) {
                                ExpenseModelView(isIncome: true, filter: filter, categTag: tag)
                                ExpenseModelView(isIncome: false, filter: filter, categTag: tag)
                            }.frame(maxWidth: .infinity)
                            ExpenseFilterTransList(filter: filter, tag: tag)
                        }
                        Spacer().frame(height: 150)
                    }.padding(.horizontal, 8).padding(.top, 0)
                    
                    Spacer()
                    
                }.edgesIgnoringSafeArea(.all)
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ExpenseFilterChartView: View {
    
    var isIncome: Bool
    var type: String
    var fetchRequest: FetchRequest<ExpenseCD>
    var expense: FetchedResults<ExpenseCD> { fetchRequest.wrappedValue }
    @AppStorage(UD_EXPENSE_CURRENCY) var CURRENCY: String = ""
    
    private func getTotalValue() -> String {
        var value = Double(0)
        for i in expense { value += i.amount }
        return "\(String(format: "%.2f", value))"
    }
    
    private func getChartModel() -> [ChartModel] {
        
        var transactions = [String: Double]()
        for i in expense {
            guard let tag = i.tag else { continue }
            if let value = transactions[tag] {
                transactions[tag] = value + i.amount
            } else { transactions[tag] = i.amount }
        }
        
        var models = [ChartModel]()
        for i in transactions {
            models.append(ChartModel(transType: getTransTagTitle(transTag: i.key), transAmount: i.value))
        }
        return models
    }
    
    init(isIncome: Bool, filter: ExpenseCDFilterTime) {
        self.isIncome = isIncome
        self.type = isIncome ? TRANS_TYPE_INCOME : TRANS_TYPE_EXPENSE
        let sortDescriptor = NSSortDescriptor(key: "occuredOn", ascending: false)
        if filter == .all {
            let predicate = NSPredicate(format: "type == %@", type)
            fetchRequest = FetchRequest<ExpenseCD>(entity: ExpenseCD.entity(), sortDescriptors: [sortDescriptor], predicate: predicate)
        } else {
            var startDate: NSDate!
            let endDate: NSDate = NSDate()
            if filter == .week { startDate = Date().getLast7Day()! as NSDate }
            else if filter == .month { startDate = Date().getLast30Day()! as NSDate }
            else { startDate = Date().getLast6Month()! as NSDate }
            let predicate = NSPredicate(format: "occuredOn >= %@ AND occuredOn <= %@ AND type == %@", startDate, endDate, type)
            fetchRequest = FetchRequest<ExpenseCD>(entity: ExpenseCD.entity(), sortDescriptors: [sortDescriptor], predicate: predicate)
        }
    }
    
    var body: some View {
        Group {
            if !expense.isEmpty {
                ChartView(label: "Total \(isIncome ? "Income" : "Expense") - \(CURRENCY)\(getTotalValue())",
                          entries: ChartModel.getTransaction(transactions: getChartModel()))
            }
        }
    }
}

struct ExpenseFilterTransList: View {
    
    var isIncome: Bool?
    var tag: String?
    var fetchRequest: FetchRequest<ExpenseCD>
    var expense: FetchedResults<ExpenseCD> { fetchRequest.wrappedValue }
    
    init(isIncome: Bool? = nil, filter: ExpenseCDFilterTime, tag: String? = nil) {
        let sortDescriptor = NSSortDescriptor(key: "occuredOn", ascending: false)
        if filter == .all {
            let predicate: NSPredicate!
            if let isIncome = isIncome {
                predicate = NSPredicate(format: "type == %@", (isIncome ? TRANS_TYPE_INCOME : TRANS_TYPE_EXPENSE))
            } else if let tag = tag { predicate = NSPredicate(format: "tag == %@", tag) }
            else { predicate = NSPredicate(format: "occuredOn <= %@", NSDate()) }
            fetchRequest = FetchRequest<ExpenseCD>(entity: ExpenseCD.entity(), sortDescriptors: [sortDescriptor], predicate: predicate)
        } else {
            var startDate: NSDate!
            let endDate: NSDate = NSDate()
            if filter == .week { startDate = Date().getLast7Day()! as NSDate }
            else if filter == .month { startDate = Date().getLast30Day()! as NSDate }
            else { startDate = Date().getLast6Month()! as NSDate }
            let predicate: NSPredicate!
            if let isIncome = isIncome {
                predicate = NSPredicate(format: "occuredOn >= %@ AND occuredOn <= %@ AND type == %@", startDate, endDate, (isIncome ? TRANS_TYPE_INCOME : TRANS_TYPE_EXPENSE))
            } else if let tag = tag {
                predicate = NSPredicate(format: "occuredOn >= %@ AND occuredOn <= %@ AND tag == %@", startDate, endDate, tag)
            } else { predicate = NSPredicate(format: "occuredOn >= %@ AND occuredOn <= %@", startDate, endDate) }
            fetchRequest = FetchRequest<ExpenseCD>(entity: ExpenseCD.entity(), sortDescriptors: [sortDescriptor], predicate: predicate)
        }
    }
    
    var body: some View {
        ForEach(self.fetchRequest.wrappedValue) { expenseObj in
            NavigationLink(destination: ExpenseDetailedView(expenseObj: expenseObj), label: { ExpenseTransView(expenseObj: expenseObj) })
        }
    }
}

struct ExpenseFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseFilterView(isIncome: true)
    }
}
