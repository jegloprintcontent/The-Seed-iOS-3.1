//
//  FCMMessaging.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 02/04/2023.
//

import Foundation
import FirebaseMessaging

struct PushMessaging {
    func subscribe( to topic: String) {
        Messaging.messaging().subscribe(toTopic: topic) { error in
            print("Subscribed to \(topic) topic")
        }
    }
}
