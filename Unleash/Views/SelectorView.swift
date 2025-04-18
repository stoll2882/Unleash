//
//  SelectorView.swift
//  Unleash
//
//  Created by Rod Toll on 4/17/25.
//

import SwiftUI

struct SelectorView: View {
    
    @Binding var currentSelection: Int
    var options: [String] = []
    var scrollable: Bool = false
    
    func getButtonWidth(width: CGFloat) -> CGFloat {
        if options.count > 3 {
            return AppConfig.Styles.MenuButton.width
        } else {
            return width / CGFloat(options.count)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            let buttonWidth = getButtonWidth(width: geometry.size.width-AppConfig.Styles.HorizontalMargin*2)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing:0) {
                    ForEach(0..<options.count, id: \.self) { index in
                        let selected = (currentSelection-1) == index
                        Button {
                            currentSelection = index+1
                        } label: {
                            Text(options[index])
                                .frame(width: buttonWidth, height:AppConfig.Styles.MenuButton.height)
                                .textMenuItem()
                        }
                        .clipShape(RoundedRectangle(cornerRadius: AppConfig.Styles.Borders.MenuBorderRadius))
                        .overlay(
                            RoundedRectangle(cornerRadius: AppConfig.Styles.Borders.CornerRadius)
                                .strokeBorder((selected) ? Color.white : Color.clear, lineWidth: AppConfig.Styles.Borders.ButtonBorderWidth)
                        )
                    }
                }
            }
            .scrollDisabled(!scrollable)
            .background(AppConfig.Styles.Colors.main_other_pink)
            .cornerRadius(AppConfig.Styles.Borders.MenuBorderRadius)
            .padding(.horizontal, AppConfig.Styles.HorizontalMargin)
        }
        .frame(height: AppConfig.Styles.MenuButton.height)
    }
}
