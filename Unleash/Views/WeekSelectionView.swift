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

struct UnderlinePicker: View {
    @Binding var selection: Int
    let workoutWeeks: [WorkoutWeek]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(getOptions(), id: \.self) { option in
                HStack {
                    VStack {
                        Text("Week \(option)")
                            .bold()
                            .foregroundColor(selection == option ? Color(AppConfig.main_neon_green) : Color(AppConfig.main_light_orange) )
                        if selection == option {
                            Spacer()
                            Rectangle()
                                .background(Color(AppConfig.main_neon_green))
                                .foregroundStyle(Color(AppConfig.main_neon_green))
                                .frame(height: 5)
                        }
                        if selection != option {
                            Spacer()
                        }
                    }
                    .frame(height: 30)
                    .onTapGesture {
                        selection = option
                    }
                }
            }
        }
    }
    
    func getOptions() -> [Int] {
        var options: [Int] = []
        for week in workoutWeeks {
            options.append(week.weekNumber)
        }
        return options
    }
}

struct WeekSelectionView: View {
    @State var selectedTab: Int = 1
    @State var trainingWeeks: [WorkoutWeek]
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        VStack {
            Image("UnleashOrange")
                .resizable()
                .frame(width: 280, height: 50)
                .padding(.vertical, 5)
            ScrollView(.horizontal) {
                UnderlinePicker(selection: $selectedTab, workoutWeeks: trainingWeeks)
            }
            .frame(height: 50)
            .padding(.horizontal, 20)
            .background(alignment: .bottom) {
                Rectangle()
                    .background(Color(AppConfig.main_light_orange))
                    .foregroundStyle(Color(AppConfig.main_light_orange))
                    .frame(height: 5)
                    .offset(y: -10)
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



//                Button {
//
//                } label: {
//                    Text("Week 1")
//                }
//                .tag(0)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 0))
//                Button {
//
//                } label: {
//                    Text("Week 2")
//                }
//                .tag(1)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 1))
//                Button {
//
//                } label: {
//                    Text("Week 3")
//                }
//                .tag(2)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 2))
//                Button {
//
//                } label: {
//                    Text("Week 2")
//                }
//                .tag(3)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 3))
//                Button {
//
//                } label: {
//                    Text("Week 3")
//                }
//                .tag(4)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 4))
//                Button {
//
//                } label: {
//                    Text("Week 4")
//                }
//                .tag(5)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 5))
//                Button {
//
//                } label: {
//                    Text("Week 5")
//                }
//                .tag(6)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 6))
//                Button {
//
//                } label: {
//                    Text("Week 6")
//                }
//                .tag(7)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 7))
//                Button {
//
//                } label: {
//                    Text("Week 7")
//                }
//                .tag(8)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 8))
//                Button {
//
//                } label: {
//                    Text("Week 8")
//                }
//                .tag(9)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 9))
//                Button {
//
//                } label: {
//                    Text("Week 9")
//                }
//                .tag(10)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 10))
//                Button {
//
//                } label: {
//                    Text("Week 10")
//                }
//                .tag(11)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 11))
//                Button {
//
//                } label: {
//                    Text("Week 11")
//                }
//                .tag(12)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 12))
//                Button {
//
//                } label: {
//                    Text("Week 12")
//                }
//                .tag(13)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 13))
//                Button {
//
//                } label: {
//                    Text("Week 13")
//                }
//                .tag(14)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 14))
//                Button {
//
//                } label: {
//                    Text("Week 14")
//                }
//                .tag(15)
//                .buttonStyle(WeekSelectionButtonStyle(isSelected: selectedTab == 15))
