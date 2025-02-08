//
//  MinistryListViewModel.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 10/12/2022.
//

import Foundation

class MinistryListViewModel: ObservableObject {
    
    @Published var ministrylist: [Article] = [Article]()
    @Published var errorMessage: String = ""
    
    //https://theseedjcli.ileewe.org/wp-json/wp/v2/posts?categories=44 - Charity, Welfare & Visitation
    //https://theseedjcli.ileewe.org/wp-json/wp/v2/posts?categories=46 - Family * Relationship
    //https://theseedjcli.ileewe.org/wp-json/wp/v2/posts?categories=49 - Outdoor Evangelism
    
    init(category: String, id: Int) {
        let urlString = "https://theseedjcli.ileewe.org/wp-json/wp/v2/posts?categories=\(id)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        print("Data - EARLY URL - \(urlString)")
        
        guard let url = URL(string: urlString) else {
            
            print("Data - EARLY URL Not OK ")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode > 400 {
                
                print("Data - EARLY An Error occured  \(statusCode)")
                return
            }
            
            DispatchQueue.main.async {
                
                guard let data = data else {
                    return
                }
                
                do {
                    self.ministrylist = try JSONDecoder().decode([Article].self, from: data)
                    print("Data - EARLY Call was made to the internet ", self.ministrylist)
                    
                }catch {
                    print("Data - Failed to decode JSON:", error)
                    self.errorMessage = error.localizedDescription
                }
            }
        }.resume()
        
        
    }
    
}
