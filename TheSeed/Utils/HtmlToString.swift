//
//  HtmlToString.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 06/12/2022.
//

import SwiftUI
import SwiftSoup


struct ParseHtml {
    func parse(html: String) -> String? {
        
        var parsed: String = ""
        do {
            let html = html
           let doc: Document = try SwiftSoup.parse(html)
           parsed = try doc.text()
        
            
        } catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print("error")
        }
        
        return parsed
    }
}
