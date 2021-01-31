//
//  ExpenseView.swift
//  Expenso
//
//  Created by Sameer Nawaz on 31/01/21.
//

import SwiftUI

struct ExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ExpenseCD.getAllExpenseData(sortBy: ExpenseCDSort.occuredOn, ascending: false)) var expense: FetchedResults<ExpenseCD>
    
    @State private var filter: ExpenseCDFilterTime = .all
    @State private var showingSheet = false
    @State private var displaySettings = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                
                VStack {
                    ToolbarModelView(title: "Dashboard", button1Icon: IMAGE_SETTINGS_ICON, button2Icon: IMAGE_FILTER_ICON) { self.presentationMode.wrappedValue.dismiss() }
                        button1Method: { self.displaySettings = true }
                        button2Method: { self.showingSheet = true }
                        .actionSheet(isPresented: $showingSheet) {
                            ActionSheet(title: Text("Select a filter"), buttons: [
                                    .default(Text("Overall")) { filter = .all },
                                    .default(Text("Last 7 days")) { filter = .week },
                                    .default(Text("Last 30 days")) { filter = .month },
                                    .cancel()
                            ])
                        }
                    ExpenseMainView(filter: filter)
                    Spacer()
                }.edgesIgnoringSafeArea(.all)
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ExpenseMainView: View {
    
    var filter: ExpenseCDFilterTime
    var fetchRequest: FetchRequest<ExpenseCD>
    var expense: FetchedResults<ExpenseCD> { fetchRequest.wrappedValue }
    @AppStorage(UD_EXPENSE_CURRENCY) var CURRENCY: String = ""
    
    init(filter: ExpenseCDFilterTime) {
        let sortDescriptor = NSSortDescriptor(key: "occuredOn", ascending: false)
        self.filter = filter
        if filter == .all {
            fetchRequest = FetchRequest<ExpenseCD>(entity: ExpenseCD.entity(), sortDescriptors: [sortDescriptor])
        } else {
            var startDate: NSDate!
            let endDate: NSDate = NSDate()
            if filter == .week { startDate = Date().getLast7Day()! as NSDate }
            else if filter == .month { startDate = Date().getLast30Day()! as NSDate }
            else { startDate = Date().getLast6Month()! as NSDate }
            let predicate = NSPredicate(format: "occuredOn >= %@ AND occuredOn <= %@", startDate, endDate)
            fetchRequest = FetchRequest<ExpenseCD>(entity: ExpenseCD.entity(), sortDescriptors: [sortDescriptor], predicate: predicate)
        }
    }
    
    private func getTotalBalance() -> String {
        var value = Double(0)
        for i in expense {
            if i.type == TRANS_TYPE_INCOME { value += i.amount }
            else if i.type == TRANS_TYPE_EXPENSE { value -= i.amount }
        }
        return "\(String(format: "%.2f", value))"
    }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: 16) {
                TextView(text: "TOTAL BALANCE", type: .overline).foregroundColor(Color.init(hex: "828282")).padding(.top, 30)
                TextView(text: "\(CURRENCY)\(getTotalBalance())", type: .h5).foregroundColor(Color.text_primary_color).padding(.bottom, 30)
            }.frame(maxWidth: .infinity).background(Color.secondary_color).cornerRadius(4)
            
            HStack(spacing: 8) {
                ExpenseModelView(isIncome: true, filter: filter)
                ExpenseModelView(isIncome: false, filter: filter)
            }.frame(maxWidth: .infinity)
            
            Spacer().frame(height: 16)
            
            HStack {
                TextView(text: "Recent Transaction", type: .subtitle_1).foregroundColor(Color.text_primary_color)
                Spacer()
            }.padding(4)
            
            ForEach(self.fetchRequest.wrappedValue) { expenseObj in
                ExpenseTransView(expenseObj: expenseObj)
            }
            
            Spacer().frame(height: 150)
            
        }.padding(.horizontal, 8).padding(.top, 0)
    }
}

struct ExpenseModelView: View {
    
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
    
    init(isIncome: Bool, filter: ExpenseCDFilterTime, categTag: String? = nil) {
        self.isIncome = isIncome
        self.type = isIncome ? TRANS_TYPE_INCOME : TRANS_TYPE_EXPENSE
        let sortDescriptor = NSSortDescriptor(key: "occuredOn", ascending: false)
        if filter == .all {
            var predicate: NSPredicate!
            if let tag = categTag {
                predicate = NSPredicate(format: "type == %@ AND tag == %@", type, tag)
            } else { predicate = NSPredicate(format: "type == %@", type) }
            fetchRequest = FetchRequest<ExpenseCD>(entity: ExpenseCD.entity(), sortDescriptors: [sortDescriptor], predicate: predicate)
        } else {
            var startDate: NSDate!
            let endDate: NSDate = NSDate()
            if filter == .week { startDate = Date().getLast7Day()! as NSDate }
            else if filter == .month { startDate = Date().getLast30Day()! as NSDate }
            else { startDate = Date().getLast6Month()! as NSDate }
            var predicate: NSPredicate!
            if let tag = categTag {
                predicate = NSPredicate(format: "occuredOn >= %@ AND occuredOn <= %@ AND type == %@ AND tag == %@", startDate, endDate, type, tag)
            } else { predicate = NSPredicate(format: "occuredOn >= %@ AND occuredOn <= %@ AND type == %@", startDate, endDate, type) }
            fetchRequest = FetchRequest<ExpenseCD>(entity: ExpenseCD.entity(), sortDescriptors: [sortDescriptor], predicate: predicate)
        }
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Spacer()
                Image(isIncome ? "income_icon" : "expense_icon").resizable().frame(width: 40.0, height: 40.0).padding(12)
            }
            HStack{
                TextView(text: isIncome ? "INCOME" : "EXPENSE", type: .overline).foregroundColor(Color.init(hex: "828282"))
                Spacer()
            }.padding(.horizontal, 12)
            HStack {
                TextView(text: "\(CURRENCY)\(getTotalValue())", type: .h5, lineLimit: 1).foregroundColor(Color.text_primary_color)
                Spacer()
            }.padding(.horizontal, 12)
        }.padding(.bottom, 12).background(Color.secondary_color).cornerRadius(4)
    }
}

struct ExpenseTransView: View {
    
    @ObservedObject var expenseObj: ExpenseCD
    @AppStorage(UD_EXPENSE_CURRENCY) var CURRENCY: String = ""
    
    var body: some View {
        HStack {
            
            Image(getTransTagIcon(transTag: expenseObj.tag ?? ""))
                .resizable().frame(width: 24, height: 24).padding(16)
                .background(Color.primary_color).cornerRadius(4)
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    TextView(text: expenseObj.title ?? "", type: .subtitle_1, lineLimit: 1).foregroundColor(Color.text_primary_color)
                    Spacer()
                    TextView(text: "\(expenseObj.type == TRANS_TYPE_INCOME ? "+" : "-")\(CURRENCY)\(expenseObj.amount)", type: .subtitle_1)
                        .foregroundColor(expenseObj.type == TRANS_TYPE_INCOME ? Color.main_green : Color.main_red)
                }
                HStack {
                    TextView(text: getTransTagTitle(transTag: expenseObj.tag ?? ""), type: .body_2).foregroundColor(Color.text_primary_color)
                    Spacer()
                    TextView(text: getDateFormatter(date: expenseObj.occuredOn, format: "MMM dd, yyyy"), type: .body_2).foregroundColor(Color.text_primary_color)
                }
            }.padding(.leading, 4)
            
            Spacer()
            
        }.padding(8).background(Color.secondary_color).cornerRadius(4)
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView()
    }
}
