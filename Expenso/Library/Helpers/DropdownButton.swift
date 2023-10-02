//
//  DropdownButton.swift
//  Expenso
//
//  Created by Sameer Nawaz on 31/01/21.
//

import SwiftUI

struct DropdownOption: Hashable {
    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
    var key: String
    var val: String
}

struct DropdownOptionElement: View {
    
    var val: String
    var key: String
    let mainColor: Color
    var onSelect: ((_ key: String) -> Void)?
    
    var body: some View {
        Button(action: {
            if let onSelect = self.onSelect {
                onSelect(self.key)
            }
        }) {
            Text(self.val).foregroundColor(mainColor).frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

struct Dropdown: View {
    
    var options: [DropdownOption]
    var onSelect: ((_ key: String) -> Void)?
    let cornerRadius: CGFloat
    let mainColor: Color
    let backgroundColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(self.options, id: \.self) { option in
                DropdownOptionElement(val: option.val, key: option.key, mainColor: self.mainColor, onSelect: self.onSelect)
            }
        }
        .padding(.vertical, 4)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(mainColor, lineWidth: 0)
        )
    }
}

struct DropdownButton: View {
    
    @Binding var shouldShowDropdown: Bool
    @Binding var displayText: String
    
    var options: [DropdownOption]
    let mainColor: Color
    let backgroundColor: Color
    let cornerRadius: CGFloat
    let buttonHeight: CGFloat
    var onSelect: ((_ key: String) -> Void)?
    
    var body: some View {
        VStack {
            Button(action: {
                self.shouldShowDropdown.toggle()
            }) {
                HStack {
                    Text(displayText).foregroundColor(mainColor)
                    Spacer()
                    Image(systemName: self.shouldShowDropdown ? "chevron.up" : "chevron.down").foregroundColor(mainColor)
                }
            }
            .padding(.horizontal)
            .cornerRadius(cornerRadius)
            .frame(height: self.buttonHeight)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius).fill(backgroundColor)
            )
            VStack {
                if self.shouldShowDropdown {
                    Dropdown(options: self.options, onSelect: self.onSelect, cornerRadius: self.cornerRadius, mainColor: self.mainColor, backgroundColor: self.backgroundColor)
                }
            }
        }.animation(.spring())
    }
}


struct DropdownOptionManager {
  func returnDropDowns(_ typeOfTransaction: TransactionType) -> [DropdownOption] {
    guard typeOfTransaction == .TRANS_TYPE_INCOME else {
      return [
        DropdownOption(key: TransactionTags.TRANS_TAG_TRANSPORT.value, val: TransactionTags.TRANS_TAG_TRANSPORT.value.capitalized),
        DropdownOption(key: TransactionTags.TRANS_TAG_FOOD.value, val: TransactionTags.TRANS_TAG_FOOD.value.capitalized),
        DropdownOption(key: TransactionTags.TRANS_TAG_HOUSING.value, val: TransactionTags.TRANS_TAG_HOUSING.value.capitalized),
        DropdownOption(key: TransactionTags.TRANS_TAG_INSURANCE.value, val: TransactionTags.TRANS_TAG_INSURANCE.value.capitalized),
        DropdownOption(key: TransactionTags.TRANS_TAG_MEDICAL.value, val: TransactionTags.TRANS_TAG_MEDICAL.value.capitalized),
        DropdownOption(key: TransactionTags.TRANS_TAG_PERSONAL.value, val: TransactionTags.TRANS_TAG_PERSONAL.value.capitalized),
        DropdownOption(key: TransactionTags.TRANS_TAG_ENTERTAINMENT.value, val: TransactionTags.TRANS_TAG_ENTERTAINMENT.value.capitalized),
        DropdownOption(key: TransactionTags.TRANS_TAG_OTHERS.value, val: TransactionTags.TRANS_TAG_OTHERS.value.capitalized),
        DropdownOption(key: TransactionTags.TRANS_TAG_UTILITIES.value, val: TransactionTags.TRANS_TAG_UTILITIES.value.capitalized)
      ]
    }
    
    return [
      DropdownOption(key: TransactionTags.TRANS_TAG_SALARY.value, val: TransactionTags.TRANS_TAG_SALARY.value.capitalized),
      DropdownOption(key: TransactionTags.TRANS_TAG_CASHBACK.value, val: TransactionTags.TRANS_TAG_CASHBACK.value.capitalized),
      DropdownOption(key: TransactionTags.TRANS_TAG_INVESTMENTRETURS.value, val:TransactionTags.TRANS_TAG_INVESTMENTRETURS.value.capitalized)
    ]
  }
}
