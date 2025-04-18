//
//  OptionButtonStyle.swift
//  Unleash
//
//  Created by Rod Toll on 4/17/25.
//

import SwiftUI

struct OptionButtonStyle: ButtonStyle {
    
    var selected: Bool = false
    var width: CGFloat = 100
    var height: CGFloat = 50
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width:width)
            .frame(height:height)
            .background(.clear)
            .foregroundStyle(.white)
            .border(selected ? Color.white : Color.clear, width: AppConfig.Styles.Borders.ButtonBorderWidth)
    }
}
