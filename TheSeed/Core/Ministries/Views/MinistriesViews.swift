//
//  MinistriesViews.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 15/10/2022.
//

import SwiftUI
import Kingfisher
import FirebaseAnalytics

struct MinistriesViews: View {
    
    @ObservedObject var vmm = HomeMinistriesViewModel()
    private let html = ParseHtml()
    
    //new addition
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                LazyVStack(spacing: 24) {
                    ForEach(vmm.ministries) { ministry in
                        
                        NavigationLink {
                            if #available(iOS 16.0, *) {
                                NavigationLazyView( MinistryListView(category: ministry.name, id: ministry.id))
                                    .toolbar(.hidden, for: .tabBar)
                            } else {
                                // Fallback on earlier versions
                                NavigationLazyView( MinistryListView(category: ministry.name, id: ministry.id))
                            }
                            
                           
                        } label: {
                            
                            VStack(alignment: .leading) {
                                
                                VStack(alignment: .leading, spacing: 8.0) {
                                    //Image(ministry.image)
                                    KFImage(URL(string: ministry.description))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        //.frame(height: 240)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(10)
                                }
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                                
                                
                                VStack(alignment: .leading) {
                                    
                                    Text(html.parse(html: ministry.name) ?? "")
                                    //HTMLLabel(html: ministry.name)
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
            .navigationTitle("Ministries")
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            .onAppear(){
                Analytics.logEvent(AnalyticsEventScreenView,
                                   parameters: [AnalyticsParameterScreenName: "Ministries",
                                               AnalyticsParameterScreenClass: "Ministries"])
                
            }
        }
        .navigationViewStyle(.stack)
    }
    
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct MinistriesViews_Previews: PreviewProvider {
    static var previews: some View {
        MinistriesViews()
    }
}
