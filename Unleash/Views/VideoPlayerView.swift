//
//  VideoPlayerView.swift
//  Unleash
//
//  Created by Sam Toll on 2/4/25.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let player: AVPlayer
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VideoPlayer(player: player)
                .onAppear {
                    player.seek(to: .zero)
                    player.play()
                }
                .onDisappear {
                    player.pause()
                    player.replaceCurrentItem(with: nil) // Full cleanup
                }
                .edgesIgnoringSafeArea(.all)

            Button(action: {
                player.pause()
                player.replaceCurrentItem(with: nil)
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
