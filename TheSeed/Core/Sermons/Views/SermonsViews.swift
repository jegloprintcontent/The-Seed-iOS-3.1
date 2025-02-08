//
//  SermonsViews.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 15/10/2022.
//

import SwiftUI
import Kingfisher
import FirebaseAnalytics


struct SermonsViews: View {
    
    @ObservedObject var vms = HomeSermonsViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                LazyVStack(spacing: 24) {
                    ForEach(vms.sermons) { sermon in
                        
                        NavigationLink {
                            //DetailView(article: sermon)
                            if #available(iOS 16.0, *) {
                                DetailsView(article: sermon)
                                    .toolbar(.hidden, for: .tabBar)
                            } else {
                                // Fallback on earlier versions
                                DetailsView(article: sermon)
                            }
                        } label: {
                            VStack(alignment: .leading) {
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    //Image(sermon.image)
                                    KFImage(URL(string: sermon.image ?? ""))
                                        .resizable()
                                        .scaledToFill()
                                        //.frame(height: 240)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(10)
                                }
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                                
                                
                                VStack(alignment: .leading) {
                                    Text(sermon.title.rendered)
                                        .font(.system(size: 20))
                                        .fontWeight(.medium)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        
                                }
                                //.frame(width: 250)
                                .padding(.vertical, 10)
                                
                            }
                        }
                        .foregroundColor(Color(.label))

                    }
                }
                .padding(.horizontal, 10)
                
            }
            .navigationTitle("Sermons")
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            .onAppear(){
                Analytics.logEvent(AnalyticsEventScreenView,
                                   parameters: [AnalyticsParameterScreenName: "Sermons",
                                               AnalyticsParameterScreenClass: "Sermons"])
                
            }
        }
        .navigationViewStyle(.stack)
    }//end of view
}

struct SermonsViews_Previews: PreviewProvider {
    static var previews: some View {
        SermonsViews()
    }
}
