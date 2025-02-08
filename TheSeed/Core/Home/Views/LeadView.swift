//
//  LeadView.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 09/12/2022.
//

import SwiftUI

struct LeadView: View {
    var body: some View {
        
        //lead devotional view
        ZStack(alignment: .bottomLeading) {
            Image("if-you-love-me")
                .resizable()
                .scaledToFill()
                .clipped()
            
            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)
            
            
            VStack(alignment: .leading) {
                Text("Devotional")
                    .font(.caption)
                    .foregroundColor(.blue)
                
                Text("Loved By Christ")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                    .multilineTextAlignment(.leading)
                
                
                Text("Oct 15, 2022")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
                
        }
        .frame(width: 400)
        
    }
}

struct LeadView_Previews: PreviewProvider {
    static var previews: some View {
        LeadView()
    }
}
