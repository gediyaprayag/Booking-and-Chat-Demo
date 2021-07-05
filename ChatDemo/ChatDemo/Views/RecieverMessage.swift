//
//  RecieverMessage.swift
//  ChatDemo
//
//  Created by Prayag Gediya on 08/06/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecieverMessage: View {
    let message: Message
    var body: some View {
        HStack {
            if let url = URL(string: message.url) {
                WebImage(url: url)
                    .resizable()
                    .placeholder(Image("picture"))
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .frame(maxHeight: 150)
            } else {
                Text(message.msg)
                    .padding(.vertical, 8)
                    .padding(.leading, 22)
                    .padding(.trailing, 22)
                    .background(Color.secondary.colorInvert())
                    .clipShape(Capsule())
            }
            Spacer()
        }.padding(.horizontal)
    }
}

struct RecieverMessage_Previews: PreviewProvider {
    static var previews: some View {
        RecieverMessage(message: Message(id: 1, msg: "Hello, How are you?", senderId: "1", url: "", timestamp: Date()))
    }
}
