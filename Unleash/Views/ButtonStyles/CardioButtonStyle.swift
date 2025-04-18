//
//  CardioButtonStyle.swift
//  Unleash
//
//  Created by Rod Toll on 4/17/25.
//

import SwiftUI

struct CardioButtonStyle: ButtonStyle {
    @Binding var selectedSetIndex: SetIndexWrapper?
    let index: Int
    @Binding var isExerciseComplete: Bool
    var isSetComplete: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 30)
            .background(isSetComplete ? Color(AppConfig.Styles.Colors.main_dark_blue) : Color(.white))
            .foregroundColor(isSetComplete ? Color(.white): Color(AppConfig.Styles.Colors.main_dark_blue))
            .border(Color(AppConfig.Styles.Colors.main_dark_blue), width: 3)
            .cornerRadius(5)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .onTapGesture {
                selectedSetIndex = SetIndexWrapper(id: index)
            }
    }
}
