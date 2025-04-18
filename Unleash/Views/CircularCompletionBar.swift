//
//  CircularCompletionBar.swift
//  Unleash
//
//  Created by Sam Toll on 2/23/25.
//

import SwiftUI

struct CircularCompletionBar: View {
    var progress: Double = 0.50 // Value between 0.0 to 1.0 (e.g., 0.75 for 75%)

    var body: some View {
        HStack {
            ZStack {
                // Background Circle (Gray)
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(Color.white)
                
                // Progress Circle (Fills according to progress)
                Circle()
                    .trim(from: 0.0, to: progress) // Only draw the fraction needed
                    .stroke(Color(AppConfig.Styles.Colors.main_neon_green), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(Angle(degrees: -90)) // Start from the top
                    .animation(.easeInOut(duration: 0.5), value: progress)
                
                // Text in the middle (Completion Percentage)
                Text("\(Int(progress * 100))%")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color(AppConfig.Styles.Colors.main_neon_green))
            }
            .frame(width: 80, height: 80) // Adjust the size of the circle
            .padding()
            Text("Completed")
                .foregroundStyle(.white)
                .font(.custom("Nexa-Heavy", size: 20))
        }
    }
}
