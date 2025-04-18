//
//  UnderlinePicker.swift
//  Unleash
//
//  Created by Rod Toll on 4/17/25.
//

import SwiftUI

struct UnderlinePicker: View {
    @Binding var selection: Int
    let workoutWeeks: [WorkoutWeek]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(getOptions(), id: \.self) { option in
                VStack(spacing: 5) { // Reduce unwanted spacer effect
                    Text("Week \(option)")
                        .bold()
                        .foregroundColor(selection == option ? Color(AppConfig.Styles.Colors.main_light_blue) : Color(AppConfig.Styles.Colors.main_other_pink))
                        .padding(.bottom, 5)
                    
                    Rectangle()
                        .frame(height: 5) // Fixed underline height
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selection == option ? Color.white : Color.clear)
                }
                .contentShape(Rectangle()) // Ensures the whole area is tappable
                .onTapGesture {
                    selection = option
                }
            }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
    }

    func getOptions() -> [Int] {
        workoutWeeks.map { $0.weekNumber }
    }
}

