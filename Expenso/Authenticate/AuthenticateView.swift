//
//  AuthenticateView.swift
//  Expenso
//
//  Created by Sameer Nawaz on 16/02/21.
//

import SwiftUI
import LocalAuthentication

struct AuthenticateView: View {
        
    @ObservedObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                
                VStack {
                    NavigationLink(destination: NavigationLazyView(ExpenseView()), isActive: $viewModel.didAuthenticate, label: {})
                    Spacer()
                    Image("pie_icon").resizable().frame(width: 120.0, height: 120.0)
                    VStack(spacing: 16) {
                        TextView(text: "\(APP_NAME) is locked", type: .body_1).foregroundColor(Color.text_primary_color).padding(.top, 20)
                        Button(action: { viewModel.authenticate() }, label: {
                            HStack {
                                Spacer()
                                TextView(text: "Unlock", type: .button).foregroundColor(Color.main_color)
                                Spacer()
                            }
                        })
                        .frame(height: 25)
                        .padding().background(Color.secondary_color)
                        .cornerRadius(4)
                        .foregroundColor(Color.text_primary_color)
                        .accentColor(Color.text_primary_color)
                    }.padding(.horizontal)
                    Spacer()
                }.edgesIgnoringSafeArea(.all)
            }
            .navigationBarHidden(true)
        }
        .onAppear(perform: {
            viewModel.authenticate()
        })
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
}

struct AuthenticateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticateView(viewModel: AuthenticationViewModel())
    }
}
