//
//  ThreadStore.swift
//  ChatDemo
//
//  Created by Prayag Gediya on 08/06/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

class ThreadStore: ObservableObject {
    @Published var threads: [Thread] = []
    
    init(testing: Bool = false) {
        if testing {
            threads = [
                .init(id: "1", users: ["1", "2"]),
                .init(id: "2", users: ["1", "2"]),
                .init(id: "3", users: ["3", "2"]),
                .init(id: "4", users: ["1", "4"])
            ]
        } else {
            fetchThreads()
        }
    }
    
    func fetchThreads() {
        Firestore.firestore().collection("threads")
            .whereField("users", arrayContains: currentId)
            .addSnapshotListener({ (snapshot, error) in
                var threads: [Thread] = []
                if let docs = snapshot?.documents {
                    for doc in docs {
                        threads.append(Thread(from: doc.data()))
                    }
                }
                threads.sort(by: { $0.updatedAt.compare($1.updatedAt) == .orderedDescending })
                self.threads = threads
                self.objectWillChange.send()
            })
    }
    
    func checkAndCreateThread(userId: String, completion: @escaping (Thread?) -> Void) {
        if let thread = threads.first(where: {$0.users.contains(userId)}) {
            return completion(thread)
        }
        let ref = Firestore.firestore().collection("threads").document()
        let thread = Thread(id: ref.documentID, users: [currentId, userId])
        ref.setData(thread.dictionary()) { error in
            if let err = error {
                print("Error : \(err.localizedDescription)")
                completion(nil)
            } else {
                completion(thread)
            }
        }
    }
    
}


class MessageStore: ObservableObject {
    @Published var thread: Thread = Thread()
    @Published var messages: [Message] = []
    @Published var message: String = ""
    
    init(testing: Bool = false, thread: Thread) {
        if testing {
            messages = [
                .init(id: 1, msg: "Hello", senderId: "1", url: "", timestamp: Date()),
                .init(id: 2, msg: "Hello, How are you?", senderId: "2", url: "", timestamp: Date()),
                .init(id: 3, msg: "I'm good", senderId: "1", url: "", timestamp: Date()),
                .init(id: 4, msg: "What are you doing?", senderId: "2", url: "", timestamp: Date()),
                .init(id: 5, msg: "Working on chat demo", senderId: "1", url: "", timestamp: Date())
            ]
        } else {
            self.thread = thread
            fetchThreadDetail()
        }
    }
    
    func fetchThreadDetail() {
        Firestore.firestore().collection("threads")
            .document(thread.id)
            .collection("messages")
            .addSnapshotListener({ (snapshot, error) in
                var messages: [Message] = []
                if let docs = snapshot?.documents {
                    for doc in docs {
                        messages.append(Message(from: doc.data()))
                    }
                }
                messages.sort(by: { $0.timestamp.compare($1.timestamp) == .orderedAscending })
                self.messages = messages
                self.objectWillChange.send()
            })
    }
    
    func sendMessage(url: String = "") {
        let id = Int((Date().timeIntervalSince1970 * 1000.0).rounded())
        let msg = Message(id: id, msg: message, senderId: currentId, url: url, timestamp: Date())
        message = ""
        Firestore.firestore().collection("threads")
            .document(thread.id)
            .updateData(["lastMessage" : msg.url != "" ? "Sent a media" : msg.msg, "updatedAt": Date()])
        Firestore.firestore().collection("threads")
            .document(thread.id)
            .collection("messages")
            .addDocument(data: msg.dict())
    }
    
    func uploadMedia(image: UIImage, completion: @escaping (_ url: String?) -> Void) {
        let storageRef = Storage.storage().reference().child(thread.id).child("Image\(Date().hashValue).png")
        if let uploadData = image.jpegData(compressionQuality: 0.5) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    completion(nil)
                } else {
                    storageRef.downloadURL(completion: { (url, error) in
                        completion(url?.absoluteString)
                    })
                }
            }
        }
    }
}
