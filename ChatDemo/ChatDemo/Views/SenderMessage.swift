//
//  SenderMessage.swift
//  ChatDemo
//
//  Created by Prayag Gediya on 08/06/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SenderMessage: View {
    let message: Message
    var body: some View {
        HStack {
            Spacer()
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
                    .padding(.trailing, 22)
                    .padding(.leading, 22)
                    .background(Color.secondary.colorInvert())
                    .clipShape(Capsule())
            }
        }
        .padding(.horizontal)
    }
}

struct SenderMessage_Previews: PreviewProvider {
    static var previews: some View {
        SenderMessage(message: Message(id: 1, msg: "Hello, How are you?", senderId: "1", url: "https://firebasestorage.googleapis.com/v0/b/swiftui-chatdemo.appspot.com/o/QnRUMV65FhAOkLtulXUc%2FImage1486971412680916536.png?alt=media&token=b10e536a-b720-4ec6-bd46-fcf515ea7928", timestamp: Date()))
    }
}
