//
//  ChatDemoApp.swift
//  ChatDemo
//
//  Created by Prayag Gediya on 08/06/21.
//

import SwiftUI
import FirebaseAuth

var currentId: String = Auth.auth().currentUser?.uid ?? ""
//var currentId: String = "9uxXdg099TGdYcJNGTxF"

@main
struct ChatDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
