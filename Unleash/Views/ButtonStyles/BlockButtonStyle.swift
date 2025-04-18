//
//  BlockButtonStyle.swift
//  Unleash
//
//  Created by Rod Toll on 4/17/25.
//

import SwiftUI

struct BlockButtonStyle: ButtonStyle {
    
    var isDefault: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: AppConfig.Styles.BlockButton.width, height: AppConfig.Styles.BlockButton.height)
            .border(Color(AppConfig.Styles.Colors.main_dark_blue), width: AppConfig.Styles.Borders.ButtonBorderWidth)
            .background(isDefault ? Color.white : Color(AppConfig.Styles.Colors.main_dark_blue))
            .cornerRadius(AppConfig.Styles.Borders.CornerRadius)
            .foregroundStyle(isDefault ? Color.black : Color.white)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .textMain()
    }
}
