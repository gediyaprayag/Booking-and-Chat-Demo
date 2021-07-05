//
//  ChatDetailScreen.swift
//  ChatDemo
//
//  Created by Prayag Gediya on 08/06/21.
//

import SwiftUI

struct ThreadDetail {
    var messages: [Message] = []
}

struct ChatDetailScreen: View {
    @ObservedObject var store: MessageStore
    @State var isShowPhotoLibrary: Bool = false
    
    var body: some View {
        content
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    store.uploadMedia(image: image) { url in
                        if let url = url {
                            self.store.sendMessage(url: url)
                        }
                    }
                }
            }
    }
    
    var content: some View {
        VStack {
            ScrollView {
                let messages = store.messages.reversed()
                ForEach(messages.indices, id: \.self) { i in
                    let msg = messages[i]
                    if msg.senderId == currentId {
                        SenderMessage(message: msg)
                            .scaleEffect(x: 1, y: -1, anchor: .center)
                    } else {
                        RecieverMessage(message: msg)
                            .scaleEffect(x: 1, y: -1, anchor: .center)
                    }
                }
            }.scaleEffect(x: 1, y: -1, anchor: .center)
            HStack {
                HStack {
                    TextField("Type a message", text: $store.message) { _ in
                        
                    } onCommit: {
                        
                    }.padding(.vertical, 12)
                    
                    Button(action: {
                        isShowPhotoLibrary = true
                    }) {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                    }
                }.padding(.horizontal)
                .background(Color.gray.opacity(0.15))
                .clipShape(Capsule())
                
                Button(action: {
                    store.sendMessage()
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            }.padding(.horizontal)
        }
    }
}

struct ChatDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailScreen(store: MessageStore(testing: true, thread: Thread()))
    }
}

