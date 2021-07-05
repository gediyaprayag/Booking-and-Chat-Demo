//
//  User.swift
//  FirebaseAuthDemo
//
//  Created by Prayag Gediya on 06/02/21.
//

import Foundation

struct User : Codable {
    var uid: String
    var email: String
    var username: String
    
    init(uid: String, email: String, username: String) {
        self.uid = uid
        self.email = email
        self.username = username
    }
    
    init(from dict: [String : Any]) {
        uid = dict["uid"] as? String ?? ""
        email = dict["email"] as? String ?? ""
        username = dict["username"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return [
            "uid" : uid,
            "email" : email,
            "username" : username
        ]
    }
    
}
