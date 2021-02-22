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
    
    func makeUIView(context: Context) -> PieChartView {
        let pieChartView = PieChartView()
        pieChartView.holeColor = UIColor.primary_color
        return pieChartView
    }
    
    func updateUIView(_ uiView: PieChartView, context: Context) {
        let dataSet = PieChartDataSet(entries: entries, label: label)
        dataSet.valueFont = UIFont.init(name: "Inter-Bold", size: 18) ?? .systemFont(ofSize: 18, weight: .bold)
        dataSet.entryLabelFont = UIFont.init(name: "Inter-Light", size: 14)
        dataSet.colors = [UIColor(hex: "#DD222D")] + [UIColor(hex: "#F9AA07")] + [UIColor(hex: "#7220DC")] + [UIColor(hex: "#1DB0F3")] +
                            [UIColor(hex: "#D21667")] + [UIColor(hex: "#EC5B2A")] + [UIColor(hex: "#FADFB4")] +
                            [UIColor(hex: "#CCCF2E")] + [UIColor(hex: "#E1C10C")] + [UIColor(hex: "#716942")]
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
