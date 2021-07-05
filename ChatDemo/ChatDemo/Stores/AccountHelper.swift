//
//  AccountHelper.swift
//  FirebaseAuthDemo
//
//  Created by Prayag Gediya on 30/01/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AccountHelper : ObservableObject {
    @Published var loggedIn: Bool = Auth.auth().currentUser != nil
    @Published var loading: Bool = false
    @Published var error: (Bool, String) = (false, "")
    @Published var users: [User] = []
    
    func createUser(email: String, password: String, username: String) {
        loading = true
        AuthenticationHelper.shared.createUser(email: email, password: password, username: username) { (user, error) in
            self.loading = false
            if let error = error {
                self.error = (true, error.localizedDescription)
                print("Error: \(error.localizedDescription)")
            } else if let user = user {
                print("User: \(user)")
                self.loggedIn = true
            } else {
                self.error = (true, "Something went wrong, please try again!")
            }
        }
    }
    
    func login(email: String, password: String) {
        loading = true
        AuthenticationHelper.shared.login(email: email, password: password) { (user, error) in
            self.loading = false
            if let error = error {
                self.error = (true, error.localizedDescription)
                print("Error: \(error.localizedDescription)")
            } else if let user = user {
                print("User: \(user)")
                self.loggedIn = true
            } else {
                self.error = (true, "Something went wrong, please try again!")
            }
        }
    }
    
    func resetPassword(email: String) {
        loading = true
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            self.loading = false
            if let error = error {
                self.error = (true, error.localizedDescription)
            } else {
                self.loggedIn = false
            }
        }
    }
    
    func fetchUsers() {
        Firestore.firestore().collection("users")
            .getDocuments { (snapshot, error) in
                var users: [User] = []
                if let docs = snapshot?.documents {
                    for doc in docs {
                        users.append(User(from: doc.data()))
                    }
                }
                if let index = users.firstIndex(where: {$0.uid == currentId}) {
                    users.remove(at: index)
                }
                self.users = users
            }
    }
}
