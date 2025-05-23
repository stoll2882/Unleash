//
//  AppConfig.swift
//  Unleash
//
//  Created by Sam Toll on 2/2/25.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

class AppConfig {

    
    class Styles {
        
        class Colors {
            static var main_nude: Color = Color(hex: 0xFFC291)
            static var main_peach: Color = Color(hex: 0xFF886A)
            static var main_mud: Color = Color(hex: 0xC8694E)
            
            static var main_dark_brown: Color = Color(hex: 0x7C4D3D)
            static var main_light_yellow: Color = Color(hex: 0xFFDC7F)
            static var main_neon_green: Color = Color(hex: 0xC5E668)
            
            static var main_mint_green: Color = Color(hex: 0xEBFFC9)
            static var main_orange_red: Color = Color(hex: 0xFE7A47)
            static var main_bright_pink: Color = Color(hex: 0xFF5757)

            static var main_orange: Color = Color(hex: 0xFFAF00)
            static var main_dark_red: Color = Color(hex: 0xC64A19)
            static var main_off_white: Color = Color(hex: 0xFFF5E1)
            
            static var main_dark_peach: Color = Color(hex: 0xEC7653)
            static var main_dark_orange: Color = Color(hex: 0xED9902)
            static var main_teal: Color = Color(hex: 0xC0DAD5)

            static var main_dark_pink: Color = Color(hex: 0xE29587)
            static var main_dark_peach_2: Color = Color(hex: 0xEA6862)
            static var main_dark_green: Color = Color(hex: 0x95B636)
            
            static var main_light_orange: Color = Color(hex: 0xFFE4DA)
            static var main_dark_blue: Color = Color(hex: 0x465AE1)
            static var main_light_blue: Color = Color(hex: 0xEFF0FA)
            static var main_other_pink: Color = Color(hex: 0xEB1563)
            
            static var main_background: Color = main_orange_red
        }
        
        class Borders {
            static var CornerRadius = CGFloat(5)
            static var ButtonBorderWidth = CGFloat(3)
            static var MenuBorderRadius = CGFloat(8)
        }
        
        static var HorizontalMargin = CGFloat(10)
        
        class Text {
            static var MainFont = "Nexa-Heavy"
            static var LightFont = "Nexa-ExtraLight"
            
            class Title {
                static var Size: CGFloat = 20
                static var Color: Color = Colors.main_neon_green
                static var Font: String = MainFont
            }
            class SubTitle {
                static var Size: CGFloat = 18
                static var Color: Color = .black
                static var Font: String = MainFont
            }
                        
            class Main {
                static var Size: CGFloat = 18
                static var Color: Color = .black
                static var Font: String = MainFont
            }
            
            class LightMain {
                static var Size: CGFloat = 18
                static var Color: Color = .black
                static var Font: String = LightFont
            }
            
            class MenuItem {
                static var Size: CGFloat = 16
                static var Color: Color = .white
                static var Font: String = MainFont
            }
        }

        
        class LogoutSheet {
            static var height_factor = CGFloat(0.85)
            static var icon_size: CGFloat = 120
        }
        
        class BlockButton {
            static var width = CGFloat(200)
            static var height = CGFloat(50)
        }
        
        class MenuButton {
            static var width = CGFloat(87)
            static var height = CGFloat(50)
        }
    }
    
}
