//
//  ExpenseSettingsView.swift
//  Expenso
//
//  Created by Sameer Nawaz on 31/01/21.
//

import SwiftUI

struct ExpenseSettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject private var viewModel = ExpenseSettingsViewModel()
    @State private var selectCurrency = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                
                VStack {
                    ToolbarModelView(title: "Settings") { self.presentationMode.wrappedValue.dismiss() }
                    
                    VStack {
                        
                        Button(action: { selectCurrency = true }, label: {
                            HStack {
                                Spacer()
                                TextView(text: "CURRENCY - \(viewModel.currency)", type: .button).foregroundColor(.white)
                                Spacer()
                            }
                        })
                        .frame(height: 25)
                        .padding().background(Color.secondary_color)
                        .cornerRadius(4)
                        .foregroundColor(Color.text_primary_color)
                        .accentColor(Color.text_primary_color)
                        .actionSheet(isPresented: $selectCurrency) {
                            var buttons: [ActionSheet.Button] = CURRENCY_LIST.map { curr in
                                ActionSheet.Button.default(Text(curr)) { viewModel.saveCurrency(currency: curr) }
                            }
                            buttons.append(.cancel())
                            return ActionSheet(title: Text("Select a currency"), buttons: buttons)
                        }
                        
                        Button(action: { viewModel.exportTransactions(moc: managedObjectContext) }, label: {
                            HStack {
                                Spacer()
                                TextView(text: "Export transactions", type: .button).foregroundColor(.white)
                                Spacer()
                            }
                        })
                        .frame(height: 25)
                        .padding().background(Color.secondary_color)
                        .cornerRadius(4)
                        .foregroundColor(Color.text_primary_color)
                        .accentColor(Color.text_primary_color)
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Button(action: { self.presentationMode.wrappedValue.dismiss() }, label: {
                                Image("tick_icon").resizable().frame(width: 32.0, height: 32.0)
                            }).padding().background(Color.main_color).cornerRadius(35)
                        }
                    }
                    .padding(.horizontal, 8).padding(.top, 1)
                    .alert(isPresented: $viewModel.showAlert,
                                        content: { Alert(title: Text(APP_NAME), message: Text(viewModel.alertMsg), dismissButton: .default(Text("OK"))) })
                }.edgesIgnoringSafeArea(.top)
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ExpenseSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseSettingsView()
    }
}
