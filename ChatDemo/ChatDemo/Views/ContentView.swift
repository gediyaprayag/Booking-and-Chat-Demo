//
//  ContentView.swift
//  FirebaseAuthDemo
//
//  Created by Prayag Gediya on 30/01/21.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @ObservedObject var store: AccountHelper = AccountHelper()
    var body: some View {
        NavigationView {
            if store.loggedIn {
                MainServiceView(aStore: store)
            } else {
                LoginView(store: store)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
