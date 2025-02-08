//
//  HomeSermonItemView.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 09/12/2022.
//

import Foundation

//
//  HomeItemView.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 06/12/2022.
//

import SwiftUI
import Kingfisher
import SDWebImageSwiftUI

struct HomeSermonItemView: View {
    
    let ministry: Ministry
    private let html = ParseHtml()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 8.0) {
                KFImage(URL(string: ministry.description))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 160)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            }
            .frame(width: 250)
            .cornerRadius(10)
            
            VStack(alignment: .leading) {
                
                HStack {
                    Spacer()
                }
                
                //Text(ministry.name)
                Text(html.parse(html: ministry.name) ?? "")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(.label))
            }
            .frame(maxWidth: 250)
            .padding(.vertical, 10)
            .multilineTextAlignment(.leading)
            
        }
        
    }
}

struct HomeSermonItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            HomeSermonItemView(ministry: .init(id: 1, description: "https://theseedjcli.ileewe.org/wp-content/uploads/2022/12/3-copy.jpeg", name: "Charity, Welfare & Visitation", slug: "welfare", parent: 57))
            
        }
        
        
    }
}
