//
//  ServiceStore.swift
//  ChatDemo
//
//  Created by mac on 14/06/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class ServiceStore: ObservableObject {
    
    static let shared = ServiceStore()
    static let testing = ServiceStore(testing: true)
    
    @Published var services: [Service] = []
    @Published var selfServices: [Service] = []
    @Published var service: Service = Service()
    
    var uid: String? { Auth.auth().currentUser?.uid }
    
    private init(testing: Bool = false) {
        if testing {
            services = Array(repeating: .init(name: "Afjs", price: "123", uid: "asdja"), count: 10)
        } else {
            //services = Array(repeating: .init(name: "Afjs", price: 123, uid: "asdja"), count: 10)
            fetchServices()
        }
    }
    
    func fetchServices() {
        guard let uid = uid else { return }
        Firestore.firestore().collection("services")
            .addSnapshotListener({ (snapshot, error) in
                var services: [Service] = []
                var selfServices: [Service] = []
                if let docs = snapshot?.documents {
                    for doc in docs {
                        //if let uid = doc.get("uid")
                        let ser20 = Service(from: doc.data())
                        if ser20.uid == uid {
                            selfServices.append(ser20)
                        } else {
                            services.append(ser20)
                        }
                    }
                    self.services = services
                    self.selfServices = selfServices
                }
                //services.sort(by: { $0.updatedAt.compare($1.updatedAt) == .orderedDescending })
            })
    }
    
    func storeServices(completion: @escaping(_ result: Bool, _ error: String?) -> Void) {
        guard let uid = uid else { return }
        let ref = Firestore.firestore().collection("services").document()
        //loading = true
        service.id = ref.documentID
        service.uid = uid
        ref.setData(service.dictionary()) { error in
                //self.loading = false
                if let err = error {
                    print("Error - createUser : \(err.localizedDescription)")
                    completion(false, err.localizedDescription)
                } else {
//                    if self.services.first(where: {$0.id == self.service.id}) == nil {
//                        self.services.insert(self.service, at: self.services.count)
//                    }
                    completion(true, nil)
                }
            }
    }
    
    func hiredUser(completion: @escaping(_ result: Bool, _ error: String?) -> Void) {
        guard let uid = uid else { return }
        let ref = Firestore.firestore().collection("services").document(self.service.id)
        ref.updateData([
            "hiredList": FieldValue.arrayUnion([uid])
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                //self.incomingUser { (res, _) in
                completion(true, nil)
                //}
            }
        }
    }
    
//    func fetchIncomings() -> [Service] {
//
//    }
    
    func incomingUser(completion: @escaping(_ result: Bool, _ error: String?) -> Void) {
        guard let uid = uid else { return }
        let ref = Firestore.firestore().collection("users").document(self.service.uid)

        ref.getDocument { (doc, error) in
            if let err = error {
                completion(false, err.localizedDescription)
            } else {
                var incomingList = doc?.get("incoming") as? [String] ?? []
                incomingList.append(uid)
                ref.setData(["incoming" : incomingList], merge: true)
                completion(true, nil)
            }
        }
    }
    
}
