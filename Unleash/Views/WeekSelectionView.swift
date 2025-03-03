//
//  WeekSelectionView.swift
//  Unleash
//
//  Created by Sam Toll on 2/2/25.
//

import SwiftUI

//struct WeekSelectionButtonStyle: ButtonStyle {
//    var isSelected: Bool
//    
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding()
//            .background(Color.clear)
//            .opacity(configuration.isPressed ? 0.5 : 1)
//            .foregroundStyle(Color.black)
//    }
//}

//struct UnderlinePicker: View {
//    @Binding var selection: Int
//    let workoutWeeks: [WorkoutWeek]
//
//    var body: some View {
//        HStack(spacing: 20) {
//            ForEach(getOptions(), id: \.self) { option in
//                HStack {
//                    VStack {
//                        Text("Week \(option)")
//                            .bold()
//                            .foregroundColor(selection == option ? Color(AppConfig.main_light_blue) : Color(AppConfig.main_other_pink) )
//                        if selection == option {
//                            Spacer()
//                            Rectangle()
//                                .background(Color(AppConfig.main_light_blue))
//                                .foregroundStyle(Color(AppConfig.main_light_blue))
//                                .frame(height: 5)
//                        }
//                        if selection != option {
//                            Spacer()
//                        }
//                    }
//                    .frame(height: 30)
//                    .onTapGesture {
//                        selection = option
//                    }
//                }
//            }
//        }
//    }
//    
//    func getOptions() -> [Int] {
//        var options: [Int] = []
//        for week in workoutWeeks {
//            options.append(week.weekNumber)
//        }
//        return options
//    }
//}

struct UnderlinePicker: View {
    @Binding var selection: Int
    let workoutWeeks: [WorkoutWeek]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(getOptions(), id: \.self) { option in
                VStack(spacing: 5) { // Reduce unwanted spacer effect
                    Text("Week \(option)")
                        .bold()
                        .foregroundColor(selection == option ? Color(AppConfig.main_light_blue) : Color(AppConfig.main_other_pink))
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

struct WeekSelectionView: View {
    @State var selectedTab: Int = 1
    @State var trainingWeeks: [WorkoutWeek]
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        VStack {
//            Image("UnleashOrange") 
//                .resizable()
//                .frame(width: 280, height: 50)
//                .padding(.vertical, 5)
            Text("Week Number \(selectedTab)")
                .bold()
                .font(.custom("Nexa-Heavy", size: 40))
                .foregroundStyle(Color(.white))
            
            ScrollView(.horizontal, showsIndicators: false) {
                UnderlinePicker(selection: $selectedTab, workoutWeeks: trainingWeeks)
            }
            .frame(height: 32)
            .padding(.horizontal, 20)
            .background(alignment: .bottom) {
                Rectangle()
                    .background(Color(AppConfig.main_other_pink))
                    .foregroundStyle(Color(AppConfig.main_other_pink))
                    .frame(height: 5)
            }

            switch(selectedTab) {
            case 1: DaySelectionTableView(weekNumber: 1)
            case 2: DaySelectionTableView(weekNumber: 2)
            case 3: DaySelectionTableView(weekNumber: 3)
            case 4: DaySelectionTableView(weekNumber: 4)
            case 5: DaySelectionTableView(weekNumber: 5)
            case 6: DaySelectionTableView(weekNumber: 6)
            case 7: DaySelectionTableView(weekNumber: 7)
            case 8: DaySelectionTableView(weekNumber: 8)
            case 9: DaySelectionTableView(weekNumber: 9)
            case 10: DaySelectionTableView(weekNumber: 10)
            case 11: DaySelectionTableView(weekNumber: 11)
            case 12: DaySelectionTableView(weekNumber: 12)
            case 13: DaySelectionTableView(weekNumber: 13)
            case 14: DaySelectionTableView(weekNumber: 14)
            default:
                DaySelectionTableView(weekNumber: 1)
            }
            Spacer()
        }
        .background(Color(AppConfig.main_background))
    }
}

struct CustomPickerItem: View {
    let option: Int
    let isSelected: Bool
    
    var body: some View {
        Text("Week \(option)")
            .padding()
            .background(isSelected ? Color.blue : Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
