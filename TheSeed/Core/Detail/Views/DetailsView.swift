//
//  DetailsView.swift
//  TheSeed
//
//  Updated by Iyanuoluwa Babatunde on 31/1/2025.
//

import SwiftUI
import Kingfisher
import FirebaseAnalytics

struct DetailsView: View {
    
    @State private var webViewHeight: CGFloat = .zero
    @State var article: Article
    private let html = ParseHtml()
    private let parsedDate = FormatDate()
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var showNavigationBar = true
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        KFImage(URL(string: article.image ?? ""))
                            .resizable()
                            .scaledToFill()
                        
                        Text(html.parse(html: article.title.rendered) ?? "")
                            .font(.title)
                            .foregroundColor(Color(.label))
                            .bold()
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 10)
                        
                        Text(FormatDate().convertDateFormat(inputDate: article.date))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                        
                        Divider()
                        
                        Webview(dynamicHeight: $webViewHeight, content: $article.content.rendered)
                            .padding(.horizontal, 10)
                            .frame(height: webViewHeight)
                    }
                }
            }

            // Floating Play/Pause Button (Appears only if audio exists)
            if let audioURLString = article.audioURL, let url = URL(string: audioURLString) {
                Button(action: {
                    if audioPlayerManager.isPlaying {
                        audioPlayerManager.pauseAudio()
                    } else {
                        audioPlayerManager.currentAudioURL = url
                        audioPlayerManager.playAudio(from: url)
                    }
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 55, height: 55) // Circle size

                        Image(systemName: audioPlayerManager.isPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25) // Icon size
                            .foregroundColor(.white)
                    }
                }
                .shadow(radius: 5)
                .padding(.bottom, 20) // Keep it properly positioned at the bottom
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                showNavigationBar.toggle()
            }
        }
        .navigationBarTitle(String(html.parse(html: article.title.rendered) ?? ""), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.backward")
                },
            trailing:
                Button(action: { share() }) {
                    Image(systemName: "square.and.arrow.up")
                }
        )
        .onAppear {
            FirebaseAnalytics.Analytics.logEvent("detail_screen_viewed", parameters: [
                AnalyticsParameterScreenName: "article_detail_view",
                "article_title": article.title.rendered, "article_url": article.link
            ])
        }
        .onDisappear {
            if audioPlayerManager.isPlaying {
                audioPlayerManager.stopAudio()
            }
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func share() {
        guard let urlShare = URL(string: article.link) else { return }
        let activityUI = UIActivityViewController(activityItems: ["The Seed App -", "I came across this on The Seed App", urlShare], applicationActivities: nil)
        
        UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }?
            .rootViewController?
            .present(activityUI, animated: true)
    }
}
