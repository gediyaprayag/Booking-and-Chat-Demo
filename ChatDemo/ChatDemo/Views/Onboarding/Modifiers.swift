//
//  Modifiers.swift
//  FirebaseAuthDemo
//
//  Created by Prayag Gediya on 30/01/21.
//

import SwiftUI

struct BorderdTextField: ViewModifier {
    let height: CGFloat
    let corner: CGFloat
    func body(content: Content) -> some View {
        content
            .frame(height: height, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: corner)
                    .stroke()
            )
    }
}

extension View {
    func borderdTextField(height: CGFloat = 50, with radius: CGFloat = 8) -> some View {
        self.modifier(BorderdTextField(height: height, corner: radius))
    }
}
