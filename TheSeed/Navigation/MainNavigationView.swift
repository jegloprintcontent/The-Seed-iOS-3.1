//
//  MainNavigationView.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 15/10/2022.
//

import SwiftUI
import FirebaseAnalytics

enum Tab {
    case home
    case seed
    case sermons
    case ministries
    case more
}

struct MainNavigationView: View {
    
    @State var selection: Tab = .home
    var body: some View {
        
        TabView(selection: $selection) {
            
            HomeView(tab: $selection)
                .onTapGesture {
//                    withAnimation(.easeIn(duration: 0.5)) {
//                        selection = .more
//                    }
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(Tab.home)
                
            
            
            SeedView()
                .onTapGesture(perform: {
                    //
                })
                .tabItem{
                    Image(systemName: "oval.portrait.bottomhalf.filled")
                    Text("The Seed")
                }.tag(Tab.seed)
            
            SermonsViews()
                .onTapGesture {
                    //
                }
                .tabItem {
                    Image(systemName: "book")
                    Text("Sermons")
                }.tag(Tab.sermons)
            
            MinistriesViews()
                .onTapGesture {
                    //
                }
                .tabItem {
                    Image(systemName: "building.2")
                    Text("Ministries")
                }.tag(Tab.ministries)
            
            MoreViews()
                .onTapGesture {
                    //
                }
                .tabItem {
                    Image(systemName: "rectangle.grid.2x2")
                    Text("More")
                }.tag(Tab.more)
            
        }
        .onAppear(){
            Analytics.logEvent(AnalyticsEventScreenView,
                               parameters: [AnalyticsParameterScreenName: "\(MainNavigationView.self)",
                                           AnalyticsParameterScreenClass: "\(MainNavigationView.self)"])
            
        }
        //.tabViewStyle(.page)
        //.indexViewStyle(.page(backgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode.always))
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigationView()
    }
}
