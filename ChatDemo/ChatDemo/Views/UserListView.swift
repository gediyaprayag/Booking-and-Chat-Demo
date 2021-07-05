//
//  HomeView.swift
//  FirebaseAuthDemo
//
//  Created by Prayag Gediya on 06/02/21.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var accountStore: AccountHelper
    @State var dataSet: Bool = false
    let action: (User) -> Void
    var body: some View {
        List {
            ForEach(accountStore.users.indices, id: \.self) { i in
                VStack(alignment: .leading) {
                    HStack {
                        Text(accountStore.users[i].username)
                            .font(.system(size: 16, weight: .medium))
                        Spacer()
                    }
                    Text(accountStore.users[i].email)
                        .font(.system(size: 12))
                }.padding(.horizontal)
                .background(Color.gray)
                .onTapGesture {
                    //create chat
                    action(accountStore.users[i])
                }
            }
        }.onAppear {
            if !dataSet {
                accountStore.fetchUsers()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(accountStore: AccountHelper()) { _ in }
    }
}
