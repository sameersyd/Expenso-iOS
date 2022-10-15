//
//  Configs.swift
//  Expenso
//
//  Created by Sameer Nawaz on 31/01/21.
//

import Foundation

// App Globals
let APP_NAME = "Expenso"
let APP_LINK = "https://github.com/sameersyd/Expenso"
let SHARED_FROM_EXPENSO = """
    Shared from \(APP_NAME) App: \(APP_LINK)
    """

// IMAGE_ICON NAMES
let IMAGE_DELETE_ICON = "delete_icon"
let IMAGE_SHARE_ICON = "share_icon"
let IMAGE_FILTER_ICON = "filter_icon"
let IMAGE_OPTION_ICON = "settings_icon"

// User Defaults
let UD_USE_BIOMETRIC = "useBiometric"
let UD_EXPENSE_CURRENCY = "expenseCurrency"

let CURRENCY_LIST = ["₹", "$", "€", "¥", "£", "¢", "₭"]

// Transaction types
let TRANS_TYPE_INCOME = "income"
let TRANS_TYPE_EXPENSE = "expense"

// Expense Transaction tags
let TRANS_TAG_TRANSPORT = "transport"
let TRANS_TAG_FOOD = "food"
let TRANS_TAG_HOUSING = "housing"
let TRANS_TAG_INSURANCE = "insurance"
let TRANS_TAG_MEDICAL = "medical"
let TRANS_TAG_SAVINGS = "savings"
let TRANS_TAG_PERSONAL = "personal"
let TRANS_TAG_ENTERTAINMENT = "entertainment"
let TRANS_TAG_UTILITIES = "utilities"

// Income Transaction tags
let TRANS_TAG_SALARY = "salary"
let TRANS_TAG_CASHBACK = "cashback"
let TRANS_TAG_INVESTMENT_RETURNS = "investment_returns"
let TRANS_TAG_SALE = "sale"

// Common Transaction tags
let TRANS_TAG_OTHERS = "others"

func getTransTagIcon(transTag: String) -> String {
    switch transTag {
        // Expenses
        case TRANS_TAG_TRANSPORT: return "trans_type_transport"
        case TRANS_TAG_FOOD: return "trans_type_food"
        case TRANS_TAG_HOUSING: return "trans_type_housing"
        case TRANS_TAG_INSURANCE: return "trans_type_insurance"
        case TRANS_TAG_MEDICAL: return "trans_type_medical"
        case TRANS_TAG_SAVINGS: return "trans_type_savings"
        case TRANS_TAG_PERSONAL: return "trans_type_personal"
        case TRANS_TAG_ENTERTAINMENT: return "trans_type_entertainment"
        case TRANS_TAG_UTILITIES: return "trans_type_utilities"
        
        // Incomes
        // TODO: Add icon sets for every income tag
        case TRANS_TAG_SALARY: return "trans_type_savings"
        case TRANS_TAG_CASHBACK: return "trans_type_savings"
        case TRANS_TAG_INVESTMENT_RETURNS: return "trans_type_savings"
        case TRANS_TAG_SALE: return "trans_type_savings"
        
        default: return "trans_type_others"
    }
}

func getTransTagTitle(transTag: String) -> String {
    switch transTag {
        // Expenses
        case TRANS_TAG_TRANSPORT: return "Transport"
        case TRANS_TAG_FOOD: return "Food"
        case TRANS_TAG_HOUSING: return "Housing"
        case TRANS_TAG_INSURANCE: return "Insurance"
        case TRANS_TAG_MEDICAL: return "Medical"
        case TRANS_TAG_SAVINGS: return "Savings"
        case TRANS_TAG_PERSONAL: return "Personal"
        case TRANS_TAG_ENTERTAINMENT: return "Entertainment"
        case TRANS_TAG_UTILITIES: return "Utilities"
        
        // Incomes
        case TRANS_TAG_SALARY: return "Salary"
        case TRANS_TAG_CASHBACK: return "Cashback"
        case TRANS_TAG_INVESTMENT_RETURNS: return "Investment Returns"
        case TRANS_TAG_SALE: return "Sale"
        
        // Common
        case TRANS_TAG_OTHERS: return "Others"
        
        default: return "Unknown"
    }
}

func getDateFormatter(date: Date?, format: String = "yyyy-MM-dd") -> String {
    guard let date = date else { return "" }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}
