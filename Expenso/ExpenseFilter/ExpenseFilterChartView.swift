//
//  ExpenseFilterChartView.swift
//  Expenso
//
//  Created by Sameer Nawaz on 18/02/21.
//

import SwiftUI
import Charts

struct ChartView: UIViewRepresentable {
    
    var label: String
    var entries: [PieChartDataEntry]
    
    func makeUIView(context: Context) -> PieChartView { return PieChartView() }
    
    func updateUIView(_ uiView: PieChartView, context: Context) {
        let dataSet = PieChartDataSet(entries: entries, label: label)
        dataSet.colors = [UIColor(hex: "#6F2F38")] + [UIColor(hex: "#7A8081")] + [UIColor(hex: "#6C7E98")] + [UIColor(hex: "#C7C1B1")] +
                            [UIColor(hex: "#BC844C")] + [UIColor(hex: "#265B75")] + [UIColor(hex: "#B0120F")] +
                            [UIColor(hex: "#3C4244")] + [UIColor(hex: "#6E5431")] + [UIColor(hex: "#716942")]
        uiView.data = PieChartData(dataSet: dataSet)
    }
}

struct ChartModel {
    
    var transType: String
    var transAmount: Double
    
    static func getTransaction(transactions: [ChartModel]) -> [PieChartDataEntry] {
        return transactions.map { PieChartDataEntry(value: $0.transAmount, label: $0.transType) }
    }
}
