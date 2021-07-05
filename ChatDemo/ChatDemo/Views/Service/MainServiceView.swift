//
//  MainServiceView.swift
//  ChatDemo
//
//  Created by mac on 14/06/21.
//

import SwiftUI
import Firebase

struct MainServiceView: View {
    @ObservedObject var aStore: AccountHelper
    @ObservedObject var store: ServiceStore = ServiceStore.shared
    @State var showCreateService = false
    @State var showService = false
    @State var presentSheet = false
   
    var body: some View {
        ZStack(alignment: .bottom) {
            
            NavigationLink(
                destination: MainView(accountStore: aStore),
                isActive: $presentSheet
            ) {
                EmptyView()
            }
            
            NavigationLink(
                destination: CreateServiceView(),
                isActive: $showCreateService
            ) {
                EmptyView()
            }
            
            NavigationLink(
                destination: CreateServiceView(isEdit: false),
                isActive: $showService ){
                EmptyView()
            }
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(store.services.indices, id: \.self) { i in
                        ServiceItem(service: store.services[i]){
                            store.service =  store.services[i]
                            showService = true
                        }
                    }
                }.padding(EdgeInsets(top: 16, leading: 16, bottom: 100, trailing: 16))
                
            }
            Button(action: createService, label: {
                Text("Create Service")
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50, alignment: .center)
                    .background(Color.black)
                    .cornerRadius(8)
            }).padding(.vertical, 20)
            .padding(.horizontal, 30)
        }
        .navigationBarItems(
            leading: Button(action: {
                presentSheet = true
            }) {
                Image(systemName: "plus.app.fill")
            },
            trailing:
                Button(action: {
                    try? Auth.auth().signOut()
                }) {
                    Text("Log Out")
                }
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Services")
    }
    
    func createService() {
        store.service = Service()
        showCreateService = true
    }
}

struct MainServiceView_Previews: PreviewProvider {
    static var previews: some View {
        MainServiceView(aStore: AccountHelper(), store: ServiceStore.testing)
    }
}

struct ServiceItem: View {
    var service: Service
    let action : () -> Void
    
    var body: some View {
        HStack(spacing: 18) {
            Text(service.name)
                .foregroundColor(.black)
            Spacer()
        }.frame(height: 52)
        .padding(.horizontal, 12)
        .background(Color.white)
        .cornerRadius(12)
        .clipped()
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0.0, y: 4)
        .onTapGesture {
            action()
        }
    }
}
