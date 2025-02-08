//
//  LoadingView.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 05/12/2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
        VStack {
            ActivityIndicatorView()
            Text("Loading...")
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))
        }
        .padding()
        .background(Color.black)
        .cornerRadius(8)
        
       
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
