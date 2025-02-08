//
//  SupportEmail.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 10/12/2022.
//

import UIKit
import SwiftUI

struct SupportEmail {
    //let toAddress: String
    //let subject: String
    let messageHeader: String
    var body: String {"""
        iOS: \(UIDevice.current.systemVersion)
        Device Model: \(UIDevice.current.modelName)
        \(messageHeader)
    ---------------------------------------------------
    """}
    
    
    func send(openURL: OpenURLAction, toAddress: String, subject: String) {
        let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        
        guard let url = URL(string: urlString) else { return }
        openURL(url) { accepted in
            if !accepted {
                print("""
                This device does not support email
                \(body)\(toAddress)
                """)
            }
        }
    }
}


