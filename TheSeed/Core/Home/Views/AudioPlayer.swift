import SwiftUI

struct FloatingAudioPlayer: View {
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager // Inject audio manager

    var body: some View {
        VStack {
            Spacer() // Push to bottom

            if audioPlayerManager.currentAudioURL != nil { // Show only if there's an audio URL
                Button(action: togglePlayPause) {
                    ZStack {
//                        Circle()
//                            .fill(Color.blue)
//                            .frame(width: 60, height: 60) // Slightly larger button for better visibility
//                            .shadow(radius: 5) // Subtle shadow effect

                        Image(systemName: audioPlayerManager.isPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 10) // Properly sized icon
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 40) // Adjust position from bottom
            }
        }
        .frame(maxWidth: .infinity) // Ensures it's centered
    }

    private func togglePlayPause() {
        if audioPlayerManager.isPlaying {
            audioPlayerManager.pauseAudio()
        } else if let url = audioPlayerManager.currentAudioURL {
            audioPlayerManager.playAudio(from: url)
        }
    }
}
