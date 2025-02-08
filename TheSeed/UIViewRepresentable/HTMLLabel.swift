//
//  HTMLLabel.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 17/12/2022.
//

import SwiftUI

struct HTMLLabel: UIViewRepresentable {
    

   let html: String
   func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
      
       let label = UILabel()
       
      DispatchQueue.main.async {
         let data = Data(self.html.utf8)
         if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                label.attributedText = attributedString
                label.font = .systemFont(ofSize: 20.0, weight: .medium)
                label.numberOfLines = 0
             label.lineBreakMode = .byTruncatingTail
             label.textAlignment = .left
             label.allowsDefaultTighteningForTruncation = true
        }
    }

       return label
   }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        
    }
    
}
