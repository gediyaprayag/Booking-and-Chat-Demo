//
//  AuthenticationHelper.swift
//  FirebaseAuthDemo
//
//  Created by Prayag Gediya on 06/02/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthenticationHelper: NSObject {
    
    private override init() {
        
    }
    
    static let shared = AuthenticationHelper()
    
    func createUser(email: String, password: String, username: String, completion: @escaping (_ result: User?, _ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(nil, error)
            } else if let uid = Auth.auth().currentUser?.uid {
                let user = User(uid: uid, email: email, username: username)
                self.storeUser(user: user, completion: completion)
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (_ result: User?, _ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(nil, error)
            } else if let uid = Auth.auth().currentUser?.uid {
                self.fetchUser(uid: uid, completion: completion)
            }
        }
    }
    
    func storeUser(user: User, completion: @escaping (_ result: User?, _ error: Error?) -> Void) {
        Firestore.firestore().collection("users").document(user.uid)
            .setData(user.dictionary()) { error in
                completion(user, error)
            }
    }
    
    func fetchUser(uid: String, completion: @escaping (_ result: User?, _ error: Error?) -> Void) {
        Firestore.firestore().collection("users").document(uid)
            .getDocument { (snapshot, error) in
                if let error = error {
                    completion(nil, error)
                } else if let dict = snapshot?.data() {
                    let user = User(from: dict)
                    completion(user, nil)
                } else {
                    completion(nil, error)
                }
            }
    }
    
}
