//
//  LoginView.swift
//  FirebaseAuthDemo
//
//  Created by Prayag Gediya on 30/01/21.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var showAlert: Bool = false
    @State var alertMsg: String = ""
    
    @ObservedObject var store: AccountHelper
    
    var body: some View {
        LoadingView(isShowing: $store.loading) { content }
            .navigationBarTitle("Login", displayMode: .inline)
    }
    
    var content: some View {
        VStack(alignment: .trailing) {
            Spacer()
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .padding(12)
                .borderdTextField()
            
            PasswordField(value: $password)
            
            NavigationLink(
                destination: ForgotPasswordView(store: store),
                label: {
                    Text("Forgot password?")
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                }).padding(.top, 8)
            
            Button(action: login, label: {
                Text("Login")
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50, alignment: .center)
                    .background(Color.black)
                    .cornerRadius(8)
            }).padding(.top, 12)
            
            Spacer()
            
            HStack {
                Spacer()
                Text("Don't have an accout?")
                    .foregroundColor(.black)
                NavigationLink(
                    destination: SignUpView(store: store),
                    label: {
                        Text("SignUp Now")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .bold))
                    })
                Spacer()
            }
            
        }.padding()
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text(alertMsg), dismissButton: .default (Text("Okay")) { })
        })
    }
    
    func login() {
        if email == "" || !email.isValidEmail() {
            alertMsg = "Enter valid email"
            showAlert = true
        } else if password == "" || password.count < 8 {
            alertMsg = "Password must be 8 characters long."
            showAlert = true
        } else {
            store.login(email: email, password: password)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(store: AccountHelper())
    }
}
