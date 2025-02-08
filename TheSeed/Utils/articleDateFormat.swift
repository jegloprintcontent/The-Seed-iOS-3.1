//
//  articleDateFormat.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 15/04/2023.
//

import Foundation

struct FormatDate {
    
    func convertDateFormat(inputDate: String?) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        guard let oldDate = olDateFormatter.date(from: inputDate ?? "") else { return " " }

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MMM dd, yyyy"

         return convertDateFormatter.string(from: oldDate)
    }
}
