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
