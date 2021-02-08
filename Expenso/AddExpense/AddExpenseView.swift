//
//  AddExpenseView.swift
//  Expenso
//
//  Created by Sameer Nawaz on 31/01/21.
//

import SwiftUI

struct AddExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var confirmDelete = false
    
    @ObservedObject var addExpenseViewModel = AddExpenseViewModel()
    
    let typeOptions = [
        DropdownOption(key: TRANS_TYPE_INCOME, val: "Income"),
        DropdownOption(key: TRANS_TYPE_EXPENSE, val: "Expense")
    ]
    
    let tagOptions = [
        DropdownOption(key: TRANS_TAG_TRANSPORT, val: "Transport"),
        DropdownOption(key: TRANS_TAG_FOOD, val: "Food"),
        DropdownOption(key: TRANS_TAG_HOUSING, val: "Housing"),
        DropdownOption(key: TRANS_TAG_INSURANCE, val: "Insurance"),
        DropdownOption(key: TRANS_TAG_MEDICAL, val: "Medical"),
        DropdownOption(key: TRANS_TAG_SAVINGS, val: "Savings"),
        DropdownOption(key: TRANS_TAG_PERSONAL, val: "Personal"),
        DropdownOption(key: TRANS_TAG_ENTERTAINMENT, val: "Entertainment"),
        DropdownOption(key: TRANS_TAG_OTHERS, val: "Others"),
        DropdownOption(key: TRANS_TAG_UTILITIES, val: "Utilities")
    ]
    
    init(expenseObj: ExpenseCD? = nil) {
        addExpenseViewModel.expenseObj = expenseObj
        addExpenseViewModel.title = expenseObj?.title ?? ""
        if let expenseObj = expenseObj {
            addExpenseViewModel.amount = String(expenseObj.amount)
            addExpenseViewModel.typeTitle = expenseObj.type == TRANS_TYPE_INCOME ? "Income" : "Expense"
        } else {
            addExpenseViewModel.amount = ""
            addExpenseViewModel.typeTitle = "Income"
        }
        addExpenseViewModel.occuredOn = expenseObj?.occuredOn ?? Date()
        addExpenseViewModel.note = expenseObj?.note ?? ""
        addExpenseViewModel.tagTitle = getTransTagTitle(transTag: expenseObj?.tag ?? TRANS_TAG_TRANSPORT)
        addExpenseViewModel.selectedType = expenseObj?.type ?? TRANS_TYPE_INCOME
        addExpenseViewModel.selectedTag = expenseObj?.tag ?? TRANS_TAG_TRANSPORT
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Group {
                        if addExpenseViewModel.expenseObj == nil {
                            ToolbarModelView(title: "Add Transaction") { self.presentationMode.wrappedValue.dismiss() }
                        } else {
                            ToolbarModelView(title: "Edit Transaction", button1Icon: IMAGE_DELETE_ICON) { self.presentationMode.wrappedValue.dismiss() }
                                button1Method: { self.confirmDelete = true }
                        }
                    }.alert(isPresented: $confirmDelete,
                            content: {
                                Alert(title: Text(APP_NAME), message: Text("Are you sure you want to delete this transaction?"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        addExpenseViewModel.deleteTransaction(managedObjectContext: self.managedObjectContext)
                                    }, secondaryButton: Alert.Button.cancel(Text("Cancel"), action: { confirmDelete = false })
                                )
                            })
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(spacing: 12) {
                            
                            TextField("Title", text: $addExpenseViewModel.title)
                                .modifier(InterFont(.regular, size: 16))
                                .accentColor(Color.text_primary_color)
                                .frame(height: 50)
                                .padding(.leading, 16)
                                .background(Color.secondary_color)
                                .cornerRadius(4)
                            
                            TextField("Amount", text: $addExpenseViewModel.amount)
                                .modifier(InterFont(.regular, size: 16))
                                .accentColor(Color.text_primary_color)
                                .frame(height: 50)
                                .padding(.leading, 16)
                                .background(Color.secondary_color)
                                .cornerRadius(4)
                                .keyboardType(.decimalPad)
                            
                            DropdownButton(shouldShowDropdown: $addExpenseViewModel.showTypeDrop, displayText: $addExpenseViewModel.typeTitle,
                                           options: typeOptions, mainColor: Color.text_primary_color,
                                           backgroundColor: Color.secondary_color, cornerRadius: 4, buttonHeight: 50) { key in
                                let selectedObj = typeOptions.filter({ $0.key == key }).first
                                if let object = selectedObj {
                                    addExpenseViewModel.typeTitle = object.val
                                    addExpenseViewModel.selectedType = key
                                }
                                addExpenseViewModel.showTypeDrop = false
                            }
                            
                            DropdownButton(shouldShowDropdown: $addExpenseViewModel.showTagDrop, displayText: $addExpenseViewModel.tagTitle,
                                           options: tagOptions, mainColor: Color.text_primary_color,
                                           backgroundColor: Color.secondary_color, cornerRadius: 4, buttonHeight: 50) { key in
                                let selectedObj = tagOptions.filter({ $0.key == key }).first
                                if let object = selectedObj {
                                    addExpenseViewModel.tagTitle = object.val
                                    addExpenseViewModel.selectedTag = key
                                }
                                addExpenseViewModel.showTagDrop = false
                            }
                            
                            HStack {
                                DatePicker("PickerView", selection: $addExpenseViewModel.occuredOn,
                                           displayedComponents: [.date, .hourAndMinute]).labelsHidden().padding(.leading, 16)
                                Spacer()
                            }
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .accentColor(Color.text_primary_color)
                            .background(Color.secondary_color)
                            .cornerRadius(4)
                            
                            TextField("Note", text: $addExpenseViewModel.note)
                                .modifier(InterFont(.regular, size: 16))
                                .accentColor(Color.text_primary_color)
                                .frame(height: 50)
                                .padding(.leading, 16)
                                .background(Color.secondary_color)
                                .cornerRadius(4)
                            
                            Spacer().frame(height: 150)
                            
                            Spacer()
                            
                        }
                        .frame(maxWidth: .infinity).padding(.horizontal, 8)
                        .alert(isPresented: $addExpenseViewModel.showAlert,
                                            content: { Alert(title: Text(APP_NAME), message: Text(addExpenseViewModel.alertMsg), dismissButton: .default(Text("OK"))) })
                    }
                    
                }.edgesIgnoringSafeArea(.top)
                
                VStack {
                    Spacer()
                    VStack {
                        Button(action: { addExpenseViewModel.saveTransaction(managedObjectContext: managedObjectContext) }, label: {
                            HStack {
                                Spacer()
                                TextView(text: addExpenseViewModel.getButtText(), type: .button).foregroundColor(.white)
                                Spacer()
                            }
                        })
                        .padding(.vertical, 12).background(Color.main_color).cornerRadius(8)
                    }.padding(.bottom, 16).padding(.horizontal, 8)
                }
                
            }
            .navigationBarHidden(true)
        }
        .dismissKeyboardOnTap()
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onReceive(addExpenseViewModel.$closePresenter) { close in
            if close { self.presentationMode.wrappedValue.dismiss() }
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}
