//
//  TransparentSheetViewExtension.swift
//  Unleash
//
//  Created by Rod Toll on 4/17/25.
//

import SwiftUI

extension View {
    func transparentSheet() -> some View {
        self.background(TransparentSheetModifier())  // ✅ Apply transparency
    }
    
    func textLightMain() -> some View {
        self
            .font(.custom(AppConfig.Styles.Text.LightMain.Font, size: AppConfig.Styles.Text.LightMain.Size))
            .bold()
            .foregroundStyle(AppConfig.Styles.Text.LightMain.Color)
    }
    
    func textMain() -> some View {
        self
            .font(.custom(AppConfig.Styles.Text.Main.Font, size: AppConfig.Styles.Text.Main.Size))
            .bold()
            .foregroundStyle(AppConfig.Styles.Text.Main.Color)
    }
    
    func textDayTitle() -> some View {
        self
            .font(.custom(AppConfig.Styles.Text.Title.Font, size: AppConfig.Styles.Text.Title.Size))
            .bold()
            .foregroundStyle(AppConfig.Styles.Text.Title.Color)
    }
    
    func textSubTitle() -> some View {
        self
            .font(.custom(AppConfig.Styles.Text.SubTitle.Font, size: AppConfig.Styles.Text.SubTitle.Size))
            .foregroundStyle(AppConfig.Styles.Text.SubTitle.Color)
    }
    
    func textMenuItem() -> some View {
        self
            .font(.custom(AppConfig.Styles.Text.MenuItem.Font, size: AppConfig.Styles.Text.MenuItem.Size))
            .bold()
            .foregroundStyle(AppConfig.Styles.Text.MenuItem.Color)
    }

}
