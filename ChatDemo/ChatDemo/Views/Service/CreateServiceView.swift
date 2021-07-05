//
//  CreateServiceView.swift
//  ChatDemo
//
//  Created by mac on 14/06/21.
//

import SwiftUI

struct CreateServiceView: View {
    
    @ObservedObject var store: ServiceStore = ServiceStore.shared
    @ObservedObject var tStore = ThreadStore(testing: false)
    @Environment(\.presentationMode) private var presentationMode
    @State var openThreadDetail = false
    @State private var thread: Thread?
    
    var isEdit: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if let thread = thread {
                NavigationLink(
                    destination: ChatDetailScreen(store: MessageStore(testing: false, thread: thread)),
                    isActive: $openThreadDetail) {
                    EmptyView()
                }
            }
            VStack(spacing: 10) {
                LabelTextFieldView(placeholder: "Name", value: $store.service.name, isEdit: .constant(isEdit))
                LabelTextFieldView(placeholder: "Price", value: $store.service.price, isEdit: .constant(isEdit))
                Spacer()
            }.padding(EdgeInsets(top: 16, leading: 16, bottom: 100, trailing: 16))
             
            if isEdit {
                Button(action: {   
                    store.storeServices { (res, _) in
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("Create")
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50, alignment: .center)
                        .background(Color.black)
                        .cornerRadius(8)
                }).padding(16)
            } else {
                HStack(spacing: 16) {
                    if let uid = store.uid , !store.service.hiredList.contains(uid) {
                        Button(action: {
                            store.hiredUser { (_, _) in
                                presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            Text("Hire")
                                .foregroundColor(.white)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 50, alignment: .center)
                                .background(Color.black)
                                .cornerRadius(8)
                        })
                    }
                    
                    Button(action: {
                        createChat()
                    }, label: {
                        Text("Chat")
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50, alignment: .center)
                            .background(Color.black)
                            .cornerRadius(8)
                    })
                }.padding(16)
            }
        }
        .navigationTitle(isEdit ? "Create Service" : "Service Details")
    }
    
    func createChat(){
        self.tStore.checkAndCreateThread(userId: store.service.uid) { thread in
            self.thread = thread
            self.openThreadDetail = true
        }
    }
}

struct CreateServiceView_Previews: PreviewProvider {
    static var previews: some View {
        CreateServiceView()
    }
}
