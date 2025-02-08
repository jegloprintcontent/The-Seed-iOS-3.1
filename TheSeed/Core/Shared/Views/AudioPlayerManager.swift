//
//  AudioPlayerManager.swift
//  TheSeed
//
//  Updated by Iyanuoluwa Babatunde on 5/1/2025.
//

import Foundation
import AVFoundation

class AudioPlayerManager: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var currentAudioURL: URL?
    @Published var currentTime: CMTime = .zero

    private var audioPlayer: AVPlayer?
    private var timeObserverToken: Any?

    var player: AVPlayer? { return audioPlayer }

    func playAudio(from url: URL) {
        if let player = audioPlayer, currentAudioURL == url {
            player.play()
            isPlaying = true
            return
        }

        stopAudio() // Stop any currently playing audio

        // AppDe Fix Background Playback by Properly Setting AudioSession
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [.allowAirPlay, .duckOthers])
            try audioSession.setActive(true)
        } catch {
            print("⚠️ Failed to configure AVAudioSession: \(error)")
        }

        // Improve Buffering for Background Audio
        let asset = AVURLAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        playerItem.preferredForwardBufferDuration = 15 // Increase buffer duration

        audioPlayer = AVPlayer(playerItem: playerItem)
        currentAudioURL = url
        isPlaying = true
        audioPlayer?.automaticallyWaitsToMinimizeStalling = false // Prevent buffering stalls
        audioPlayer?.play()

        startObservingProgress()
    }

    func pauseAudio() {
        audioPlayer?.pause()
        isPlaying = false
    }

    func resumeAudio() {
        audioPlayer?.play()
        isPlaying = true
    }

    func stopAudio() {
        audioPlayer?.pause()
        audioPlayer = nil
        isPlaying = false
        currentAudioURL = nil
        currentTime = .zero
        stopObservingProgress()
    }

    func seek(to time: CMTime) {
        audioPlayer?.seek(to: time)
    }

    private func startObservingProgress() {
        timeObserverToken = audioPlayer?.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1, preferredTimescale: 1),
            queue: .main
        ) { [weak self] time in
            self?.currentTime = time
        }
    }

    private func stopObservingProgress() {
        if let token = timeObserverToken {
            audioPlayer?.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
}
