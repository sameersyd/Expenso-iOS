//
//  MonthlyTransactionDetailedView.swift
//  Expenso
//
//  Created by Hendrik Steen on 02.06.22.
//

import SwiftUI

struct MonthlyTransactionDetailedView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject private var viewModel: MonthlyTransactionDetailedViewModel
    @AppStorage(UD_EXPENSE_CURRENCY) var CURRENCY: String = ""
    
    @State private var confirmDelete = false
    
    init(monthlyTransactionObj: MonthlyExpenseCD) {
       viewModel = MonthlyTransactionDetailedViewModel(monthlyTransactionObj: monthlyTransactionObj)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    ToolbarModelView(title: "Details", button1Icon: IMAGE_DELETE_ICON, button2Icon: IMAGE_SHARE_ICON) { self.presentationMode.wrappedValue.dismiss() }
                        button1Method: { self.confirmDelete = true }
                        button2Method: { viewModel.shareNote() }
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(spacing: 24) {
                            ExpenseDetailedListView(title: "Title", description: viewModel.monthlyTransactionObj.title ?? "")
                            ExpenseDetailedListView(title: "Amount", description: "\(CURRENCY)\(viewModel.monthlyTransactionObj.amount)")
                            ExpenseDetailedListView(title: "Transaction type", description: viewModel.monthlyTransactionObj.type == TRANS_TYPE_INCOME ? "Income" : "Expense" )
                            ExpenseDetailedListView(title: "Tag", description: getTransTagTitle(transTag: viewModel.monthlyTransactionObj.tag ?? ""))
                            ExpenseDetailedListView(title: "When", description: getDateFormatter(date: viewModel.monthlyTransactionObj.usingDate, format: "EEEE, dd MMM hh:mm a"))
                            if let note = viewModel.monthlyTransactionObj.note, note != "" {
                                ExpenseDetailedListView(title: "Note", description: note)
                            }
                            if let data = viewModel.monthlyTransactionObj.imageAttached {
                                VStack(spacing: 8) {
                                    HStack { TextView(text: "Attachment", type: .caption).foregroundColor(Color.init(hex: "828282")); Spacer() }
                                    Image(uiImage: UIImage(data: data)!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 250).frame(maxWidth: .infinity)
                                        .background(Color.secondary_color)
                                        .cornerRadius(4)
                                }
                            }
                        }.padding(16)
                        
                        Spacer().frame(height: 24)
                        Spacer()
                    }
                    .alert(isPresented: $confirmDelete,
                                content: {
                                    Alert(title: Text(APP_NAME), message: Text("Are you sure you want to delete this transaction?"),
                                        primaryButton: .destructive(Text("Delete")) {
                                            viewModel.deleteNote(managedObjectContext: managedObjectContext)
                                        }, secondaryButton: Alert.Button.cancel(Text("Cancel"), action: { confirmDelete = false })
                                    )
                                })
                }.edgesIgnoringSafeArea(.all)
                //TODO: Edit View for Monthly Expense
//                VStack {
//                    Spacer()
//                    HStack {
//                        Spacer()
//                        NavigationLink(destination: EditMonthlyTransactionView(viewModel: AddExpenseViewModel(expenseObj: nil, monthlyTransactionObj: viewModel.monthlyTransactionObj)), label: {
//                            Image("pencil_icon").resizable().frame(width: 28.0, height: 28.0)
//                            Text("Edit").modifier(InterFont(.semiBold, size: 18)).foregroundColor(.white)
//                        })
//                        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 20))
//                        .background(Color.main_color).cornerRadius(25)
//                    }.padding(24)
//                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
