//
//  UnderlineExerciseTypePicker.swift
//  Unleash
//
//  Created by Rod Toll on 4/17/25.
//

import SwiftUI
import Collections

struct UnderlineExerciseTypePicker: View {
    @Binding var selection: Int
    let workoutTypes: [Int]
    var labels: [String]
    var width: Double
    
    var body: some View {
        HStack {
            ForEach(workoutTypes, id: \.self) { option in
                VStack {
                    Text("\(labels[option])")
                        .bold()
                        .foregroundColor(selection == option ? Color(AppConfig.Styles.Colors.main_light_blue) : .black)
                        .frame(width: (width/Double(workoutTypes.count) - 20.0/3.0))
                        .onTapGesture {
                            selection = option
                        }
                    if selection == option {
                        Spacer()
                        Rectangle()
                            .background(Color(AppConfig.Styles.Colors.main_light_blue))
                            .foregroundStyle(Color(AppConfig.Styles.Colors.main_light_blue))
                            .frame(height: 5)
                    }
                    if selection != option {
                        Spacer()
                    }
                }
            }
        }
        .frame(height: 30)
        .padding(.horizontal, 20)
    }
}
