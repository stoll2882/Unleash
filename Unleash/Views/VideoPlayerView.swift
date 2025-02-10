//
//  VideoPlayerView.swift
//  Unleash
//
//  Created by Sam Toll on 2/4/25.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videoURL: URL
    @Environment(\.presentationMode) var presentationMode
    private let player: AVPlayer
    
    init(videoURL: URL) {
        self.videoURL = videoURL
        self.player = AVPlayer(url: videoURL)

        // Force audio to play even in silent mode
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        try? AVAudioSession.sharedInstance().setActive(true)
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VideoPlayer(player: player)
                .onAppear {
                    player.play()
                }
                .onDisappear {
                    player.pause()
                }
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                player.pause()
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}
