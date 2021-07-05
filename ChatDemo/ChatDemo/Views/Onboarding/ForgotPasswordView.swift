//
//  ForgotPasswordView.swift
//  FirebaseAuthDemo
//
//  Created by Prayag Gediya on 30/01/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email: String = ""
    
    @ObservedObject var store: AccountHelper
    
    var body: some View {
        LoadingView(isShowing: $store.loading) { content }
            .navigationBarTitle("Forgot Password", displayMode: .inline)
    }
    
    var content: some View {
        VStack {
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .padding(12)
                .borderdTextField()
            
            Button(action: resetPassword, label: {
                Text("Continue")
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50, alignment: .center)
                    .background(Color.black)
                    .cornerRadius(8)
            }).padding(.top, 12)
        }.padding(12)
    }
    
    func resetPassword() {
        store.resetPassword(email: email)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(store: AccountHelper())
    }
}
