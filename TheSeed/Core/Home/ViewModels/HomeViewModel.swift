//
//  HomeViewModel.swift
//  TheSeed
//
//  Updated by Iyanuoluwa Babatunde on 16/1/2025.


import Foundation
import SwiftUI
import AVFoundation

class HomeViewObservable: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var articles: [Article] = [Article]()
    @Published var leadArticle: Article?
    @Published var theSeeds: [Article] = [Article] ()
    @Published var errorMessage: String = ""
    @Published var currentAudioURL: URL? // URL of the currently playing audio
    @Published var isAudioPlaying: Bool = false // Tracks audio playback status

    private var audioPlayer: AVPlayer? // Player for audio playback

    // This init method can be used to start fetching posts when the view model is created
    init() {
        fetchPosts() // Fetch posts as soon as the view model is initialized
    }

    // Function to fetch posts (with audioURL parsing)
    func fetchPosts() {
        // The URL for the xAPI endpoint
        let urlString = "https://theseedjcli.ileewe.org/wp-json/wp/v2/posts"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        guard let url = URL(string: urlString) else {
            self.isLoading = false
            self.errorMessage = "Invalid URL"
            return
        }

        // Start the network request
        isLoading = true
        URLSession.shared.dataTask(with: url) { data, response, err in
            // Handle errors
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Error: Bad Response (Status Code: \(statusCode))"
                    print("Error: An error occurred... Status Code: \(statusCode)")
                }
                return
            }

            if let error = err {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    print("Error: An error occurred... \(error.localizedDescription)")
                }
                return
            }

            // Handle successful data response
            DispatchQueue.main.async {
                            
                            guard let data = data else {
                                print(data ?? 0)
                                return
                            }
                            
                            do {
                                print("Data - Call was made to the internet")
                                self.articles = try JSONDecoder().decode([Article].self, from: data)
                                self.theSeeds = self.articles
                                self.leadArticle = self.articles.remove(at: 0)
                                //print("Data - Places array: \(self.articles)")
                                for article in self.articles {
                                                    print("Fetched Audio URL: \(article.audioURL ?? "No Audio")") // <-- Check this
                                                }
                                
                            } catch {
                                print("Data - Failed to decode JSON:", error)
                                self.errorMessage = error.localizedDescription
                                self.isLoading = false
                            }

                // Finish loading
                self.isLoading = false
            }

        }.resume()
    }

    // Function to play audio
    func playAudio(for article: Article) {
        guard let audioURLString = article.audioURL, let url = URL(string: audioURLString) else {
            print("Invalid audio URL for the article")
            return
        }

        // Stop current audio if playing
        if isAudioPlaying {
            stopAudio()
        }

        // Initialize player with the new URL
        currentAudioURL = url
        audioPlayer = AVPlayer(url: url)
        audioPlayer?.play()
        isAudioPlaying = true
    }

    // Function to pause audio
    func pauseAudio() {
        audioPlayer?.pause()
        isAudioPlaying = false
    }

    // Function to stop audio
    func stopAudio() {
        audioPlayer?.pause()
        audioPlayer = nil
        isAudioPlaying = false
    }

    // Function to toggle audio playback
    func toggleAudio(for article: Article) {
        if let currentURL = currentAudioURL, currentURL.absoluteString == article.audioURL {
            if isAudioPlaying {
                pauseAudio()
            } else {
                audioPlayer?.play()
                isAudioPlaying = true
            }
        } else {
            playAudio(for: article)
        }
    }
}
