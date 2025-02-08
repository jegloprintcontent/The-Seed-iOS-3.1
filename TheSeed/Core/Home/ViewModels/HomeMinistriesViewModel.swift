//
//  HomeMinistriesViewModel.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 09/12/2022.
//

import Foundation
import SwiftUI


class HomeMinistriesViewModel: ObservableObject {
    
    @Published var ministries: [Ministry] = [Ministry]()
    @Published var errorMessage: String = ""
    
    // 1 - "https://theseedjcli.ileewe.org/wp-json/wp/v2/categories?parent=57&per_page=10 - Ministries By DB
    // 2 - "https://theseedjcli.ileewe.org/apps/v1/list-ministries.json" - Ministries By Server Files
    // 3 - "https://jeglo.s3.eu-west-2.amazonaws.com/apps/theseed/v1/list-ministries.json" - Ministries By Bucket Files
    
    init() {
        let urlString = "https://jeglo.s3.eu-west-2.amazonaws.com/apps/theseed/v1/list-ministries.json"
        
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
                    self.ministries = try JSONDecoder().decode([Ministry].self, from: data)
                }catch {
                    print("Data - Failed to decode JSON:", error)
                    self.errorMessage = error.localizedDescription
                }
            }
        }.resume()
        
        
    }
    
}
