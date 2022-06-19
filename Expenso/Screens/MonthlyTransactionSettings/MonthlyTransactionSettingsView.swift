//
//  MonthlyTransactionSettings.swift
//  Expenso
//
//  Created by Hendrik Steen on 13.06.22.
//

import SwiftUI

struct MonthlyTransactionSettingsView: View {
     @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @FetchRequest(fetchRequest: ExpenseCD.sortExpenseDataByFrequency(frequency: Frequency.monthly)) var monthlyExpenses: FetchedResults<ExpenseCD>
     var body: some View {
         NavigationView {
             ZStack {
                 Color.primary_color.edgesIgnoringSafeArea(.all)

                 VStack {
                     ToolbarModelView(title: "Monthly Transaction") { self.presentationMode.wrappedValue.dismiss() }
                     ScrollView {
                         ForEach(monthlyExpenses) { expenseObj in
                             NavigationLink(destination: ExpenseDetailedView(expenseObj: expenseObj, editViewHasToggle: true), label: { ExpenseTransView(expenseObj: expenseObj) })
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

struct MonthlyTransactionSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyTransactionSettingsView()
    }
}
