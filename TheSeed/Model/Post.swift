//
//  Post.swift
//  TheSeed
//
//  Updated by Lawrence Adeyemi on 6/1/2025.
//

import Foundation

struct Post: Identifiable, Decodable, Hashable{
    
    var id = UUID()
    var title: String
    var author: String
    var content: String
    var image: String
    var audioURL: URL?//For the audio
     
}

var posts = [Post(id: UUID(), title: "Power of Reconciliation To All Christians", author: "The Seed", content: "", image: "reconciliation-pic"), Post(id: UUID(), title: "The Inseparable Bond", author: "The Seed", content: "", image: "creation"), Post(id: UUID(), title: "Letting Down The Nets", author: "The Seed", content: "", image: "letting"), Post(id: UUID(), title: "Basis Of Your Creation", author: "The Seed", content: "", image: "just"), Post(id: UUID(), title: "Keys To Effectual Prayers", author: "The Seed", content: "", image: "prayer")]

var sermons = [Post(id: UUID(), title: "Encounter With Jesus", author: "", content: "", image: "encounter-with-jesus"), Post(id: UUID(), title: "God Is Not Man That He Should Lie", author: "", content: "", image: "god-is-not-man")]

var ministries = [Post(id: UUID(), title: "Charity, Welfare & Visitation", author: "", content: "", image: "charity-welfare-visitation"), Post(id: UUID(), title: "Family & Relationships", author: "", content: "", image: "family-relationships"), Post(id: UUID(), title: "Outdoor Evangelism", author: "", content: "", image: "outdoor-evangelism")]

/*
var test: [Post] = [
    .init(title: <#T##String#>, author: <#T##String#>, content: <#T##String#>, image: <#T##String#>),
]
 */
