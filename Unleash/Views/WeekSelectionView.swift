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

struct WeekSelectionView: View {
    @State var selectedTab: Int = 1
    @State var trainingWeeks: [WorkoutWeek]
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    @State var currentSelection = 0
    
    func getSelections() -> [String] {
        var selections: [String] = []
        for week in trainingWeeks {
            selections.append("Week \(week.weekNumber)")
        }
        return selections
    }
    
    var body: some View {
        VStack {
            SelectorView(currentSelection: $selectedTab, options: getSelections(), scrollable: true)
                .padding(.top)
            
            DaySelectionTableView(weekNumber: selectedTab)
            
            Spacer()
        }
        .background(Color(AppConfig.Styles.Colors.main_background))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("UnleashOrange")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 32)
            }
        }
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
