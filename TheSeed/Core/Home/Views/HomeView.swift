//
//  HomeView.swift
//  TheSeed
//
//  Updated by Iyanuoluwa Babatunde on 30/1/2025.
//

import SwiftUI
import Kingfisher
import SDWebImageSwiftUI
import FirebaseAnalytics
import AVFoundation

struct HomeView: View {
    
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    @Binding var tab: Tab
    @ObservedObject var vml = HomeViewObservable()
    @ObservedObject var vmm = HomeMinistriesViewModel()
    @ObservedObject var vms = HomeSermonsViewModel()
    private let html = ParseHtml()
    private let parsedDate = FormatDate()
    
    var body: some View {
        NavigationView {
            ZStack {
                if vml.isLoading {
                    LoadingView()
                } else {
                    ScrollView {
                        VStack(alignment: .leading) {
                            NavigationLink {
                                if let article = vml.leadArticle {
                                    DetailsView(article: article)
                                }
                            } label: {
                                leadView
                            }
                            
                            devotionalView
                            sermonView
                            ministriesView
                        }
                    }
                }

                // Shows Floating Audio Player only if there's an audio URL
//                if let _ = audioPlayerManager.currentAudioURL {
//                    FloatingAudioPlayer(
//                        isPlaying: $audioPlayerManager.isPlaying,
//                        currentAudioURL: $audioPlayerManager.currentAudioURL
//                    )
//
//                        .padding()
//                        .background(Color.red)
//                        .edgesIgnoringSafeArea(.all)
//                }
       }
            .navigationTitle("Home")
            .onAppear {
                Analytics.logEvent(AnalyticsEventScreenView, parameters: [
                    AnalyticsParameterScreenName: "Home",
                    AnalyticsParameterScreenClass: "Home"
                ])
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    @State static var selection: Tab = .home
    static var previews: some View {
        HomeView(tab: $selection).environmentObject(AudioPlayerManager())
    }
}

extension HomeView {
    var leadView: some View {
        ZStack(alignment: .bottomLeading) {
            KFImage(URL(string: vml.leadArticle?.image ?? ""))
                .resizable()
                .scaledToFill()
            
            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)
            
            VStack(alignment: .leading) {
                Text("Devotional")
                    .font(.caption)
                    .padding(4)
                    .background(RoundedRectangle(cornerRadius: 4, style: .continuous).fill(Color.white))
                    .foregroundColor(.blue)
                
                Text(html.parse(html: vml.leadArticle?.title.rendered ?? "Welcome") ?? "")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                    .multilineTextAlignment(.leading)

                Text(FormatDate().convertDateFormat(inputDate: vml.leadArticle?.date ?? ""))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }

    var devotionalView: some View {
        VStack {
            HStack {
                Text("Devotionals")
                    .font(.title2)
                    .bold()
                Spacer()
                Button {
                    self.tab = .seed
                    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                        AnalyticsParameterScreenName: "Show All Seeds",
                        AnalyticsParameterSource: "Home"
                    ])
                } label: {
                    Text("Show all")
                        .font(.subheadline)
                        .frame(width: 100, height: 32)
                        .foregroundColor(Color(.label))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(vml.articles) { article in
                        NavigationLink {
                            DetailsView(article: article)
                        } label: {
                            HomeItemView(article: article)
                        }
                    }
                }
                .padding(16)
            }
        }
    }

    var sermonView: some View {
        VStack {
            HStack {
                Text("Sermons")
                    .font(.title2)
                    .bold()
                Spacer()
                Button {
                    self.tab = .sermons
                    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                        AnalyticsParameterScreenName: "Show All Sermons",
                        AnalyticsParameterSource: "Home"
                    ])
                } label: {
                    Text("Show all")
                        .font(.subheadline)
                        .frame(width: 100, height: 32)
                        .foregroundColor(Color(.label))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 16) {
                    ForEach(vms.sermons) { sermon in
                        NavigationLink {
                            DetailsView(article: sermon)
                        } label: {
                            HomeItemView(article: sermon)
                        }
                    }
                }
                .padding(16)
            }
        }
    }

    var ministriesView: some View {
        VStack {
            HStack {
                Text("Ministries")
                    .font(.title2)
                    .bold()
                Spacer()
                Button {
                    self.tab = .ministries
                    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                        AnalyticsParameterContent: "Show All Ministries",
                        AnalyticsParameterSource: "Home"
                    ])
                } label: {
                    Text("Show all")
                        .font(.subheadline)
                        .frame(width: 100, height: 32)
                        .foregroundColor(Color(.label))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 16) {
                    ForEach(vmm.ministries) { ministry in
                        NavigationLink {
                            MinistryListView(category: ministry.name, id: ministry.id)
                        } label: {
                            HomeSermonItemView(ministry: ministry)
                        }
                    }
                }
                .padding(16)
            }
        }
    }
}
