//
//  PasswordField.swift
//  FirebaseAuthDemo
//
//  Created by Prayag Gediya on 06/02/21.
//

import SwiftUI

struct PasswordField: View {
    @Binding var value: String
    var placeholder: String = "Password"
    @State var toggle: Bool = false
    var body: some View {
        ZStack(alignment: .trailing) {
            if toggle {
                TextField(placeholder, text: $value)
                    .padding(12)
                    .padding(.trailing, 40)
                    .borderdTextField()
            } else {
                SecureField(placeholder, text: $value)
                    .padding(12)
                    .padding(.trailing, 40)
                    .borderdTextField()
            }
            Button(action: {
                toggle.toggle()
            }) {
                Image(toggle ? "invisible" : "visible")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25, alignment: .center)
            }.padding(.trailing, 12)
        }
    }
}

struct PasswordField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordField(value: .constant(""))
    }
}
