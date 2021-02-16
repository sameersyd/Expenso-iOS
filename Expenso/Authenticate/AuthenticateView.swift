//
//  AuthenticateView.swift
//  Expenso
//
//  Created by Sameer Nawaz on 16/02/21.
//

import SwiftUI
import LocalAuthentication

struct AuthenticateView: View {
    
    @State private var didAuthenticate = false
    
    @State private var alertMsg = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                
                VStack {
                    NavigationLink(destination: NavigationLazyView(ExpenseView()), isActive: $didAuthenticate, label: {})
                    Spacer()
                    Image("pie_icon").resizable().frame(width: 120.0, height: 120.0)
                    VStack(spacing: 16) {
                        TextView(text: "\(APP_NAME) is locked", type: .body_1).foregroundColor(Color.text_primary_color).padding(.top, 20)
                        Button(action: { self.authenticate() }, label: {
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
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock \(APP_NAME)"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success { self.didAuthenticate = true }
                    else { alertMsg = authenticationError?.localizedDescription ?? "Error"; showAlert = true }
                }
            }
        } else if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Please authenticate yourself to unlock \(APP_NAME)"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success { self.didAuthenticate = true }
                    else { alertMsg = authenticationError?.localizedDescription ?? "Error"; showAlert = true }
                }
            }
        }
    }
}

struct AuthenticateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticateView()
    }
}
