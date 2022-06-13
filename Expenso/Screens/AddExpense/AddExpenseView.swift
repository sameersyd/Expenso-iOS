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
    @State var showAttachSheet = false
    
    @StateObject var viewModel: AddExpenseViewModel
    
    var hasToggle: Bool = true
    
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
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Group {
                        if viewModel.expenseObj == nil {
                            ToolbarModelView(title: "Add Transaction") { self.presentationMode.wrappedValue.dismiss() }
                        } else {
                            ToolbarModelView(title: "Edit Transaction", button1Icon: IMAGE_DELETE_ICON) { self.presentationMode.wrappedValue.dismiss() }
                                button1Method: { self.confirmDelete = true }
                        }
                    }.alert(isPresented: $confirmDelete,
                            content: {
                                Alert(title: Text(APP_NAME), message: Text("Are you sure you want to delete this transaction?"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        viewModel.deleteTransaction(managedObjectContext: self.managedObjectContext)
                                    }, secondaryButton: Alert.Button.cancel(Text("Cancel"), action: { confirmDelete = false })
                                )
                            })
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(spacing: 12) {
                            
                            TextField("Title", text: $viewModel.title)
                                .modifier(InterFont(.regular, size: 16))
                                .accentColor(Color.text_primary_color)
                                .frame(height: 50).padding(.leading, 16)
                                .background(Color.secondary_color)
                                .cornerRadius(4)
                            
                            TextField("Amount", text: $viewModel.amount)
                                .modifier(InterFont(.regular, size: 16))
                                .accentColor(Color.text_primary_color)
                                .frame(height: 50).padding(.leading, 16)
                                .background(Color.secondary_color)
                                .cornerRadius(4).keyboardType(.decimalPad)
                            
                            DropdownButton(shouldShowDropdown: $viewModel.showTypeDrop, displayText: $viewModel.typeTitle,
                                           options: typeOptions, mainColor: Color.text_primary_color,
                                           backgroundColor: Color.secondary_color, cornerRadius: 4, buttonHeight: 50) { key in
                                let selectedObj = typeOptions.filter({ $0.key == key }).first
                                if let object = selectedObj {
                                    viewModel.typeTitle = object.val
                                    viewModel.selectedType = key
                                }
                                viewModel.showTypeDrop = false
                            }
                            
                            DropdownButton(shouldShowDropdown: $viewModel.showTagDrop, displayText: $viewModel.tagTitle,
                                           options: tagOptions, mainColor: Color.text_primary_color,
                                           backgroundColor: Color.secondary_color, cornerRadius: 4, buttonHeight: 50) { key in
                                let selectedObj = tagOptions.filter({ $0.key == key }).first
                                if let object = selectedObj {
                                    viewModel.tagTitle = object.val
                                    viewModel.selectedTag = key
                                }
                                viewModel.showTagDrop = false
                            }
                            
                            HStack {
                                DatePicker("PickerView", selection: $viewModel.occuredOn,
                                           displayedComponents: [.date, .hourAndMinute]).labelsHidden().padding(.leading, 16)
                                Spacer()
                            }
                            .frame(height: 50).frame(maxWidth: .infinity)
                            .accentColor(Color.text_primary_color)
                            .background(Color.secondary_color).cornerRadius(4)
                            
                            TextField("Note", text: $viewModel.note)
                                .modifier(InterFont(.regular, size: 16))
                                .accentColor(Color.text_primary_color)
                                .frame(height: 50).padding(.leading, 16)
                                .background(Color.secondary_color)
                                .cornerRadius(4)
                            
                            if hasToggle {
                                //MARK: User can define Transaction as monthly when it is created or change it to onetime, when in the Monthly Transaction View. The User is not allowed to change the state from onetime to monthly in the recent transaction list to prevent that the transaction is done more than one time monthly. If it should be monthly the user has to created a new Expense
                                Toggle("monthly", isOn: $viewModel.monthlyFrequency)
                                    .padding(5)
                                    .accentColor(Color.text_primary_color)
                                    .frame(height: 50).padding(.leading, 16)
                                    .background(Color.secondary_color)
                                    .cornerRadius(4)
                            }
                            
                            Button(action: { viewModel.attachImage() }, label: {
                                HStack {
                                    Image(systemName: "paperclip")
                                        .font(.system(size: 18.0, weight: .bold))
                                        .foregroundColor(Color.text_secondary_color)
                                        .padding(.leading, 16)
                                    TextView(text: "Attach an image", type: .button).foregroundColor(Color.text_secondary_color)
                                    Spacer()
                                }
                            })
                            .frame(height: 50).frame(maxWidth: .infinity)
                            .background(Color.secondary_color)
                            .cornerRadius(4)
                            .actionSheet(isPresented: $showAttachSheet) {
                                ActionSheet(title: Text("Do you want to remove the attachment?"), buttons: [
                                    .default(Text("Remove")) { viewModel.removeImage() },
                                    .cancel()
                                ])
                            }
                            
                            
                            if let image = viewModel.imageAttached {
                                Button(action: { showAttachSheet = true }, label: {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 250).frame(maxWidth: .infinity)
                                        .background(Color.secondary_color)
                                        .cornerRadius(4)
                                })
                            }
                            
                            Spacer().frame(height: 150)
                        }
                        .frame(maxWidth: .infinity).padding(.horizontal, 8)
                        .alert(isPresented: $viewModel.showAlert,
                               content: { Alert(title: Text(APP_NAME), message: Text(viewModel.alertMsg), dismissButton: .default(Text("OK"))) })
                    }
                    
                }.edgesIgnoringSafeArea(.top)
                
                VStack {
                    Spacer()
                    VStack {
                        Button(action: { viewModel.saveTransaction(managedObjectContext: managedObjectContext) }, label: {
                            HStack {
                                Spacer()
                                TextView(text: viewModel.getButtText(), type: .button).foregroundColor(.white)
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
        .onReceive(viewModel.$closePresenter) { close in
            if close { self.presentationMode.wrappedValue.dismiss() }
        }
    }
}

//struct AddExpenseView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddExpenseView()
//    }
//}
