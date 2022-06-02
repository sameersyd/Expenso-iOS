//
//  MonthlyTransactionSettingsView.swift
//  Expenso
//
//  Created by Hendrik Steen on 01.06.22.
//

import SwiftUI

struct MonthlyTransactionSettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @FetchRequest(fetchRequest: MonthlyExpenseCD.getAllMonthlyExpenseData()) var monthlyTransactions: FetchedResults<MonthlyExpenseCD>
    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                
                VStack {
                    ToolbarModelView(title: "Monthly Transaction") { self.presentationMode.wrappedValue.dismiss() }
                    ScrollView {
                        ForEach(self.monthlyTransactions) { monthlyTransactionObj in
                            NavigationLink(destination: MonthlyTransactionDetailedView(monthlyTransactionObj: monthlyTransactionObj), label: { MonthlyTransView(monthlyTransactionObj: monthlyTransactionObj) })
                        }
                        
                    }
                    .padding(.horizontal, 8)
                }.edgesIgnoringSafeArea(.all)
            }
            .navigationBarHidden(true)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
        
}

struct MonthlyTransView: View {
    
    @ObservedObject var monthlyTransactionObj: MonthlyExpenseCD
    @AppStorage(UD_EXPENSE_CURRENCY) var CURRENCY: String = ""
    
    var body: some View {
        HStack {
            
            NavigationLink(destination: NavigationLazyView(ExpenseFilterView(categTag: monthlyTransactionObj.tag)), label: {
                Image(getTransTagIcon(transTag: monthlyTransactionObj.tag ?? ""))
                    .resizable().frame(width: 24, height: 24).padding(16)
                    .background(Color.primary_color).cornerRadius(4)
            })
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    TextView(text: monthlyTransactionObj.title ?? "", type: .subtitle_1, lineLimit: 1).foregroundColor(Color.text_primary_color)
                    Spacer()
                    TextView(text: "\(monthlyTransactionObj.type == TRANS_TYPE_INCOME ? "+" : "-")\(CURRENCY)\(monthlyTransactionObj.amount)", type: .subtitle_1)
                        .foregroundColor(monthlyTransactionObj.type == TRANS_TYPE_INCOME ? Color.main_green : Color.main_red)
                }
                HStack {
                    TextView(text: getTransTagTitle(transTag: monthlyTransactionObj.tag ?? ""), type: .body_2).foregroundColor(Color.text_primary_color)
                    Spacer()
                    TextView(text: "made on: ", type: .body_2).foregroundColor(Color.text_primary_color)
                    TextView(text: getDateFormatter(date: monthlyTransactionObj.usingDate, format: "MMM dd, yyyy"), type: .body_2).foregroundColor(Color.text_primary_color)
                }
            }.padding(.leading, 4)
            
            Spacer()
            
        }.padding(8).background(Color.secondary_color).cornerRadius(4)
    }
}
