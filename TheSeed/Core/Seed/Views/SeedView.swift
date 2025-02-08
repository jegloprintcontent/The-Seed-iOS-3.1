//
//  SeedView.swift
//  TheSeed
//
//  Updated by Iyanuoluwa Babatunde on 31/1/2025.
//

import SwiftUI
import Kingfisher
import FirebaseAnalytics

struct SeedView: View {
    @ObservedObject var vml = HomeViewObservable()
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager // Inject Audio Manager

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVStack(spacing: 24) {
                        ForEach(vml.theSeeds) { seed in
                            NavigationLink(destination: DetailsView(article: seed)) {
                                SectionTileView(article: seed)
                                    .foregroundColor(Color(.label))
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                if let audioURLString = seed.audioURL, let url = URL(string: audioURLString) {
                                    print("✅ Setting Audio URL: \(url)") // Debugging
                                    audioPlayerManager.currentAudioURL = url
                                } else {
                                    print("❌ No Audio for this post")
                                }
                            })
                        }
                    }
                    .padding(.horizontal, 10)
                }
                
                // Floating Audio Player (Appears only when an audio file exists)
//                if let _ = audioPlayerManager.currentAudioURL {
//                    FloatingAudioPlayer()
//                        .padding()
//                        .edgesIgnoringSafeArea(.all)
//                }
            }
            .navigationTitle("The Seed")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                Analytics.logEvent(AnalyticsEventScreenView, parameters: [
                    AnalyticsParameterScreenName: "Seeds",
                    AnalyticsParameterScreenClass: "Seeds"
                ])
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct SeedView_Previews: PreviewProvider {
    static var previews: some View {
        SeedView().environmentObject(AudioPlayerManager()) // Inject Audio Player
    }
}
