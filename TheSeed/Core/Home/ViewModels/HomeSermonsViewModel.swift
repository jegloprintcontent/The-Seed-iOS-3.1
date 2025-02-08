//
//  HomeSermonsViewModel.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 09/12/2022.
//

import Foundation

class HomeSermonsViewModel: ObservableObject {
    
    @Published var sermons: [Article] = [Article]()
    @Published var errorMessage: String = ""
    
    // 1 - "https://theseedjcli.ileewe.org/wp-json/wp/v2/posts?categories=56&per_page=10" - Sermons DB
    // 2 - "https://theseedjcli.ileewe.org/apps/v1/latest-sermons.json" - Sermons By Server files
    // 3 - https://jeglo.s3.eu-west-2.amazonaws.com/apps/theseed/v1/latest-sermons.json - Sermons By S3 bucket
    
    init() {
        let urlString = "https://jeglo.s3.eu-west-2.amazonaws.com/apps/theseed/v1/latest-sermons.json"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode > 400 {
                return
            }
            
            DispatchQueue.main.async {
                
                guard let data = data else {
                    return
                }
                
                do {
                    self.sermons = try JSONDecoder().decode([Article].self, from: data)
                }catch {
                    print("Data - Failed to decode JSON:", error)
                    self.errorMessage = error.localizedDescription
                }
            }
        }.resume()
        
        
    }
    
}
