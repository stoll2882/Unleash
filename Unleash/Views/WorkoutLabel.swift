//
//  WorkoutLabel.swift
//  Unleash
//
//  Created by Sam Toll on 2/4/25.
//

import SwiftUI

struct WorkoutLabel: View {
    var weekNumber: Int
    var dayNumber: Int
    var workoutName: String
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("WEEK \(weekNumber) | DAY \(dayNumber)")
                    .font(.custom("Nexa-Heavy", size: 40))
                    .foregroundStyle(Color(.white))
                Text("\(workoutName)")
                    .font(.custom("Nexa-Heavy", size: 25))
                    .foregroundStyle(Color(.white))
            }
//            ZStack {
//                Rectangle()
//                    .frame(height: 200)
//                    .foregroundStyle(Color(AppConfig.main_neon_green))
//                VStack {
//                    Image("UnleashLogoSmall")
//                        .resizable()
//                        .frame(width: 200, height: 50)
//                        .padding(.bottom, -10)
//                    Text("WEEK \(weekNumber): DAY \(dayNumber)")
//                        .font(.system(size: 40))
//                        .bold()
//                        .fontWeight(.heavy)
//                        .foregroundStyle(Color(AppConfig.main_bright_pink))
//                    Text(workoutName)
//                        .foregroundStyle(Color.white)
//                        .font(.system(size: 22))
//                        .bold()
//                    HStack {
//                        Image(systemName: "timer")
//                            .foregroundStyle(Color.white)
//                        Text("60 minutes")
//                            .foregroundStyle(Color.white)
//                            .font(.system(size: 22))
//                    }
//                }
//            }
            Spacer()
        }
        .padding(10)
    }
}
