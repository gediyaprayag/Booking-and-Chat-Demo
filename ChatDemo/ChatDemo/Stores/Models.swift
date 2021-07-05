//
//  Models.swift
//  ChatDemo
//
//  Created by mac on 09/06/21.
//

import Foundation
import FirebaseFirestore

struct Thread {
    var id: String = ""
    var users: [String] = [""]
    var lastMessage: String = ""
    var updatedAt: Date = Date()
    
    init() {
        
    }
    
    init(id: String, users: [String]) {
        self.id = id
        self.users = users
        self.lastMessage = "Last Message"
    }
    
    init(from dict: [String : Any]) {
        id = dict["id"] as? String ?? ""
        users = dict["users"] as? [String] ?? []
        lastMessage = dict["lastMessage"] as? String ?? ""
        if let updatedAt = dict["updatedAt"] as? Timestamp {
            self.updatedAt = updatedAt.dateValue()
        }
    }
    
    func dictionary() -> [String : Any] {
        let dict: [String : Any] = [
            "id" : id,
            "users" : users,
            "lastMessage": lastMessage
        ]
        return dict
    }
    
}

struct Message {
    var id: Int = 0
    var msg: String = ""
    var senderId: String = ""
    var url: String = ""
    var timestamp: Date = Date()
    
    init() {
        
    }
    
    init(id: Int, msg: String, senderId: String, url: String, timestamp: Date) {
        self.id = id
        self.msg = msg
        self.senderId = senderId
        self.url = url
        self.timestamp = timestamp
    }
    
    init(from dict: [String : Any]) {
        id = dict["id"] as? Int ?? 0
        msg = dict["msg"] as? String ?? ""
        senderId = dict["senderId"] as? String ?? ""
        url = dict["url"] as? String ?? ""
        if let timestamp = dict["timestamp"] as? Timestamp {
            self.timestamp = timestamp.dateValue()
        }
    }
    
    func dict() -> [String : Any] {
        let dict: [String : Any] = [
            "id" : id,
            "msg" : msg,
            "senderId" : senderId,
            "url" : url,
            "timestamp": timestamp
        ]
        return dict
    }
}
