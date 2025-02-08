//
//  Article.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 05/12/2022.
//

import Foundation

struct Article: Identifiable, Decodable {

   
    var id: Int
    var date: String
    var guid: Guid
    
    struct Guid: Decodable {
        var rendered: String
    }
    
    var slug: String
    var link: String
    var title: Title
    
    struct Title: Decodable {
        var rendered: String
    }
    
    var content: Content
    
    struct Content: Decodable {
        var rendered: String
    }
    
    var excerpt: Excerpt
    
    struct Excerpt: Decodable {
        var rendered: String
    }
    
    var author: Int
    var categories: [Int]
    var tags: [Int]
    var article_author: String
    var image: String?
    var audioURL: String?
    
}

