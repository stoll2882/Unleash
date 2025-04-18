//
//  PlayButtonStyle.swift
//  Unleash
//
//  Created by Rod Toll on 4/17/25.
//
import SwiftUI

struct PlayButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
