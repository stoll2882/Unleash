//
//  WeightEntryButtonStyle.swift
//  Unleash
//
//  Created by Rod Toll on 4/17/25.
//

import SwiftUI

struct WeightEntryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .foregroundColor(Color(AppConfig.Styles.Colors.main_neon_green))
            .frame(width: 100, height: 20)
            .overlay(
                Rectangle()
                    .fill(Color(AppConfig.Styles.Colors.main_neon_green))
                    .frame(height: 2)
                    .offset(y: 10),
                alignment: .bottom
            )
    }
}
