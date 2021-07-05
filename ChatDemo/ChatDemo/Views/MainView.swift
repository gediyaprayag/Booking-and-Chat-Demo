//
//  ContentView.swift
//  ChatDemo
//
//  Created by Prayag Gediya on 08/06/21.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var store = ThreadStore(testing: false)
    @ObservedObject var accountStore: AccountHelper
    @State private var presentSheet: Bool = false
    @State private var thread: Thread?
    @State private var openThreadDetail: Bool = false
    
    var body: some View {
        ZStack {
            if let thread = thread {
                NavigationLink(
                    destination: ChatDetailScreen(store: MessageStore(testing: false, thread: thread)),
                    isActive: $openThreadDetail) {
                    EmptyView()
                }
            }
            List {
                ForEach(store.threads.indices, id: \.self) { i in
                    ChatItem(thread: store.threads[i])
                    .onTapGesture {
                        self.thread = store.threads[i]
                        self.openThreadDetail = true
                    }
                }
            }
        }.navigationBarItems(trailing:
                                Button(action: {
                                    presentSheet = true
                                }) {
                                    Image(systemName: "plus.app.fill")
                                }
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Threads")
        .sheet(isPresented: $presentSheet, content: {
            UserListView(accountStore: accountStore) { user in
                self.store.checkAndCreateThread(userId: user.uid) { thread in
                    self.presentSheet = false
                    self.thread = thread
                    self.openThreadDetail = true
                }
            }
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(store: ThreadStore(testing: true), accountStore: AccountHelper())
    }
}

struct ChatItem: View {
    let thread: Thread
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(thread.id)
                    .font(.system(size: 16, weight: .medium))
                Spacer()
            }
            Text(thread.lastMessage)
                .font(.system(size: 12))
        }.padding(.horizontal)
    }
}
