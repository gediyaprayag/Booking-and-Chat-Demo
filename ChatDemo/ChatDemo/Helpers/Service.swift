//
//  ServiceDetail.swift
//  ChatDemo
//
//  Created by mac on 14/06/21.
//

import Foundation

struct Service: Codable {
    var id: String = ""
    var name: String = ""
    var price: String = ""
    var uid: String = ""
    var hiredList : [String] = []
    
    init() {
    }
    
    init(name: String, price: String, uid: String) {
        self.name = name
        self.price = price
        self.uid = uid
    }
    
    init(from dict: [String : Any]) {
        id = dict["id"] as? String ?? ""
        name = dict["name"] as? String ?? ""
        price = String(dict["price"] as? Int ?? 0)
        uid = dict["uid"] as? String ?? ""
        hiredList = dict["hiredList"] as? [String] ?? []
    }
    
    func dictionary() -> [String : Any] {
        return [
            "id" : id,
            "name" : name,
            "price" : Int(price) ?? 0,
            "uid" : uid,
        ]
    }
}
