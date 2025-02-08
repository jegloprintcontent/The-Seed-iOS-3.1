//
//  Ministry.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 09/12/2022.
//

import Foundation

struct Ministry: Decodable, Identifiable {
    var id: Int
    var description: String
    var name: String
    var slug: String
    var parent: Int
}
