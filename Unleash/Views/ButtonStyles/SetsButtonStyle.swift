//
//  SetsButtonStyle.swift
//  Unleash
//
//  Created by Rod Toll on 4/17/25.
//

import SwiftUI

struct SetsButtonStyle: ButtonStyle {
    @Binding var selectedButtons: Set<Int>
    @Binding var isShowingEntryView: Bool
    @Binding var selectedSetIndex: SetIndexWrapper?
    let index: Int
    @Binding var isExerciseComplete: Bool
    @Binding var activeSheet: SheetType?
    var isSetComplete: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 30)
            .background((selectedButtons.contains(index) || isSetComplete) ? Color(AppConfig.Styles.Colors.main_dark_blue) : Color(.white))
            .foregroundColor((selectedButtons.contains(index) || isSetComplete) ? Color(.white): Color(AppConfig.Styles.Colors.main_dark_blue))
            .border(Color(AppConfig.Styles.Colors.main_dark_blue), width: 3)
            .cornerRadius(5)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .onTapGesture {
                selectedSetIndex = SetIndexWrapper(id: index)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    activeSheet = .dataEntry(selectedSetIndex!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isShowingEntryView = true
                }
//                selectedButtons.insert(index)
            }
    }
}
