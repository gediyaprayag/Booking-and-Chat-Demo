//
//  IncomingServiceView.swift
//  ChatDemo
//
//  Created by mac on 15/06/21.
//

import SwiftUI

struct IncomingServiceView: View {
    
    @ObservedObject var store: ServiceStore = ServiceStore.shared
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(store.selfServices.indices, id: \.self) { i in
                    ServiceItem(service: store.selfServices[i]){
                        store.service =  store.selfServices[i]
//                        showService = true
                    }
                }
            }.padding(EdgeInsets(top: 16, leading: 16, bottom: 100, trailing: 16))
            
        }
    }
}

struct IncomingServiceView_Previews: PreviewProvider {
    static var previews: some View {
        IncomingServiceView()
    }
}
