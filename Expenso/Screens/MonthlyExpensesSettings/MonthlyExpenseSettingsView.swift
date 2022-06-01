//
//  MonthlyExpenseSettingsView.swift
//  Expenso
//
//  Created by Hendrik Steen on 01.06.22.
//

import SwiftUI

struct MonthlyExpenseSettingsView: View {
    @FetchRequest(fetchRequest: MonthlyExpenseCD.getAllMonthlyExpenseData()) var monthlyExpenses: FetchedResults<MonthlyExpenseCD>
    var body: some View {
        ScrollView {
            ForEach(monthlyExpenses) { monthlyExpenseObj in
                HStack {
                    Text(monthlyExpenseObj.title ?? "no title")
                    Text(monthlyExpenseObj.tag ?? "no tag")
                }
            }
        }
    }
}

struct MonthlyExpenseSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyExpenseSettingsView()
    }
}
