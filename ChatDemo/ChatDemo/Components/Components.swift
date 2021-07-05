//
//  BorderedTextField.swift
//  ChatDemo
//
//  Created by mac on 14/06/21.
//

import SwiftUI

struct BorderedTextField : View {
    var placeholder: String = "First Name"
    @Binding var value: String
    var keyboardType: UIKeyboardType = .default
    var isSecureField: Bool = false
    @State var visible: Bool = false
    var onEditingChanged: (Bool) -> Void = {_ in}
    var onCommit: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                if isSecureField && !visible {
                    SecureField(placeholder, text: $value)
                        .keyboardType(keyboardType)
                        .autocapitalization((keyboardType == .emailAddress || isSecureField) ? .none : .sentences)
                } else {
                    TextField(placeholder, text: $value, onEditingChanged: onEditingChanged, onCommit: onCommit)
                        .keyboardType(keyboardType)
                        .autocapitalization((keyboardType == .emailAddress || isSecureField) ? .none : .sentences)
                }
                if isSecureField {
                    Button(action: {
                        visible.toggle()
                    }, label: {
                        Image(systemName: visible ? "eye.slash.fill": "eye.fill")
                            .foregroundColor(Color.black.opacity(0.75))
                    }).frame(width: 15, height: 15)
                }
            }
            Divider()
        }
    }
}

struct LabelTextFieldView: View {
    var placeholder: String
    @Binding var value: String
    @Binding var isEdit: Bool
    var body: some View {
        VStack(spacing: 6) {
            Text(placeholder)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.black)
            if isEdit {
                BorderedTextField(placeholder: placeholder, value: $value)
            } else {
                Text(value)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.black).opacity(0.8)
            }
        }
    }
}

struct BorderedTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BorderedTextField(value: .constant("Abc"))
            LabelTextFieldView(placeholder: "Name", value: .constant(""), isEdit: .constant(true))
        }
    }
}
