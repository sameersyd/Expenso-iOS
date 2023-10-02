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
//let TRANS_TYPE_INCOME = "income"
//let TRANS_TYPE_EXPENSE = "expense"


enum TransactionType: String {
  case TRANS_TYPE_INCOME = "income"
  case TRANS_TYPE_EXPENSE = "expense"
}

// Transaction tags enum
enum TransactionTags {
  case TRANS_TAG_TRANSPORT
  case TRANS_TAG_FOOD
  case TRANS_TAG_HOUSING
  case TRANS_TAG_INSURANCE
  case TRANS_TAG_MEDICAL
  case TRANS_TAG_SAVINGS
  case TRANS_TAG_PERSONAL
  case TRANS_TAG_ENTERTAINMENT
  case TRANS_TAG_OTHERS
  case TRANS_TAG_UTILITIES
  case TRANS_TAG_SALARY
  case TRANS_TAG_CASHBACK
  case TRANS_TAG_INVESTMENTRETURS
  
  var value: String {
    switch self {
    case .TRANS_TAG_TRANSPORT:
      return "transport"
    case .TRANS_TAG_FOOD:
      return "food"
    case .TRANS_TAG_HOUSING:
      return  "housing"
    case .TRANS_TAG_INSURANCE:
      return "insurance"
    case .TRANS_TAG_MEDICAL:
      return "medical"
    case .TRANS_TAG_SAVINGS:
      return "savings"
    case .TRANS_TAG_PERSONAL:
      return "personal"
    case .TRANS_TAG_ENTERTAINMENT:
      return "entertainment"
    case .TRANS_TAG_OTHERS:
      return "others"
    case .TRANS_TAG_UTILITIES:
      return "utilities"
    case .TRANS_TAG_SALARY:
      return "salary"
    case .TRANS_TAG_CASHBACK:
      return "cashback"
    case .TRANS_TAG_INVESTMENTRETURS:
      return "investment Returns"
    }
  }
  
  
  static func getTransactionTitle(_ type: String) -> String {
    let title = switch type {
    case TRANS_TAG_TRANSPORT.value:
       "transport"
    case TRANS_TAG_FOOD.value:
       "food"
    case TRANS_TAG_HOUSING.value:
        "housing"
    case TRANS_TAG_INSURANCE.value:
       "insurance"
    case TRANS_TAG_MEDICAL.value:
       "medical"
    case TRANS_TAG_SAVINGS.value:
       "savings"
    case TRANS_TAG_PERSONAL.value:
       "personal"
    case TRANS_TAG_ENTERTAINMENT.value:
       "entertainment"
    case TRANS_TAG_OTHERS.value:
       "others"
    case TRANS_TAG_UTILITIES.value:
       "utilities"
    case TRANS_TAG_SALARY.value:
       "salary"
    case TRANS_TAG_CASHBACK.value:
       "cashback"
    case TRANS_TAG_INVESTMENTRETURS.value:
       "investment Returns"
    default:
       "unknown"
    }
    
    return title.capitalized
  }
}

func getTransTagIcon(transTag: String) -> String {
    switch transTag {
    case TransactionTags.TRANS_TAG_TRANSPORT.value: return "trans_type_transport"
    case  TransactionTags.TRANS_TAG_FOOD.value: return "trans_type_food"
    case  TransactionTags.TRANS_TAG_HOUSING.value: return "trans_type_housing"
    case  TransactionTags.TRANS_TAG_INSURANCE.value: return "trans_type_insurance"
    case  TransactionTags.TRANS_TAG_MEDICAL.value: return "trans_type_medical"
    case  TransactionTags.TRANS_TAG_SAVINGS.value: return "trans_type_savings"
    case  TransactionTags.TRANS_TAG_PERSONAL.value: return "trans_type_personal"
    case  TransactionTags.TRANS_TAG_ENTERTAINMENT.value: return "trans_type_entertainment"
    case  TransactionTags.TRANS_TAG_OTHERS.value: return "trans_type_others"
    case  TransactionTags.TRANS_TAG_UTILITIES.value: return "trans_type_utilities"
        default: return "trans_type_others"
    }
}



func getDateFormatter(date: Date?, format: String = "yyyy-MM-dd") -> String {
    guard let date = date else { return "" }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}
