//
//  ExerciseBlockView.swift
//  Unleash
//
//  Created by Sam Toll on 2/4/25.
//

import SwiftUI
import FirebaseFirestore

struct ExerciseBlockView: View {
    @State var exercise: ProgramExercise
    @State var isPresentingVideo: Bool = false
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    @State var loading: Bool = true
    
    @State var padding: Int

    @State private var selectedButtons: Set<Int> = []
    @State private var isShowingEntryView: Bool = false
    @State private var selectedSetIndex: SetIndexWrapper?
    @State private var numberOfSets: Int?
    @State private var mostRecentSets: [WorkoutSet] = []
    @State private var isExerciseComplete: Bool = false  // ✅ Store exercise completion
    
    var weekNumber: Int
    var dayNumber: Int
    
    @State private var activeSheet: SheetType?
    
    private func loadExerciseHistory() {
        DispatchQueue.main.async {
            if let setsString = exercise.sets, let firstChar = setsString.first, let setsCount = Int(String(firstChar)) {
                self.numberOfSets = setsCount
                self.mostRecentSets = (0..<setsCount).map { WorkoutSet(setIndex: $0) }
            }
            
            let allHistoryInstances: [ExerciseHistoryInstance] = appDataStore.getObjectsContainingID(from: appDataStore.activeUser.exerciseHistory, containing: exercise.exerciseID)
            
            // Filter out history instances that do not have a valid date
            let filteredHistory = allHistoryInstances.filter { $0.dateCompleted != nil }
            
            // Sort by `dateCompleted`, placing the most recent first
            let sortedHistory = filteredHistory.sorted { $0.dateCompleted! > $1.dateCompleted! }
            
            if exercise.exerciseName == "Band Pull Aparts" {
                print("here")
            }
                        
            // Return the sets from the most recent instance, or an empty array if none exist
            let mostRecentInstance: ExerciseHistoryInstance? = sortedHistory.first
            if let instanceToCheck = mostRecentInstance {
                // Instance of exercise is completed already
                if (instanceToCheck.exerciseId == exercise.exerciseID && instanceToCheck.weekNumber == weekNumber && instanceToCheck.dayNumber == dayNumber) {
                    isExerciseComplete = instanceToCheck.completed!
                    for index in 0..<instanceToCheck.sets!.count {
                        mostRecentSets[index] = instanceToCheck.sets![index]
                    }
                // Exercise has been done before, but not same instance
                } else {
                    var smallerVal = numberOfSets!
                    if instanceToCheck.sets!.count < smallerVal {
                        smallerVal = instanceToCheck.sets!.count
                    }
                    for index in 0..<smallerVal {
                        mostRecentSets[index].weight = instanceToCheck.sets![index].weight
                        mostRecentSets[index].reps = instanceToCheck.sets![index].reps
                        mostRecentSets[index].unit = instanceToCheck.sets![index].unit
                        mostRecentSets[index].setIndex = instanceToCheck.sets![index].setIndex
                    }
                }
            }
            loading = false
        }
    }

    // Checks if all sets have been logged and marks exercise as complete
    private func updateExerciseCompletion(setIndex: Int, weight: Double, reps: Int, unit: String) {
        DispatchQueue.main.async {
            let newSet = WorkoutSet(setIndex: setIndex, weight: weight, reps: reps, unit: unit, completed: true)
            isExerciseComplete = appDataStore.logExerciseData(firebaseManager: firebaseManager, exerciseId: exercise.exerciseID, weekNumber: weekNumber, dayNumber: dayNumber, newSet: newSet, numSets: numberOfSets ?? 0)
            loadExerciseHistory()
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(exercise.exerciseName!)
                        .font(.custom("Nexa-Heavy", size: 25))
                        .bold()
                        .padding(.bottom, 5)

                    if !loading {
                        HStack {
                            ForEach(0..<numberOfSets!, id: \.self) { index in
                                let set = mostRecentSets[index]
                                Button {
                                    selectedSetIndex = SetIndexWrapper(id: index)
                                } label: {
                                    HStack {
                                        if set.completed! {
                                            Text("\(set.reps ?? 0) | \(set.weight ?? 0, specifier: "%.1f") \(set.unit ?? "")")
                                                .foregroundColor((selectedButtons.contains(index) || isExerciseComplete) ? Color(.white) : Color(AppConfig.main_dark_blue))
                                                .bold()
                                                .foregroundStyle(.white)
                                                .font(.custom("Nexa-Heavy", size: 12))
                                        } else if set.weight != nil {
                                            Text("\(set.reps ?? 0) | \(set.weight ?? 0, specifier: "%.1f") \(set.unit ?? "")")
                                                .foregroundColor((selectedButtons.contains(index) || isExerciseComplete) ? Color(.white) : Color(AppConfig.main_dark_blue))
                                                .bold()
                                                .font(.custom("Nexa-Heavy", size: 12))
                                        } else {
                                            Text("\(self.exercise.reps!)")
                                                .foregroundColor((selectedButtons.contains(index) || isExerciseComplete) ? Color(.white) : Color(AppConfig.main_dark_blue))
                                                .bold()
                                                .font(.custom("Nexa-Heavy", size: 12))
                                        }
                                    }
                                }
                                .buttonStyle(SetsButtonStyle(selectedButtons: $selectedButtons, isShowingEntryView: $isShowingEntryView, selectedSetIndex: $selectedSetIndex, index: index, isExerciseComplete: $isExerciseComplete, activeSheet: $activeSheet, isSetComplete: mostRecentSets[index].completed!))
                                .disabled(isExerciseComplete)
                            }
                        }
                    }
                }
                .padding(.trailing, 10)
                Spacer()
                VStack {
                    if isExerciseComplete {
                        Image("Complete")
                            .resizable()
                            .foregroundStyle(Color(AppConfig.main_bright_pink))
                            .frame(width: 40, height: 40)
//                            .padding(.trailing, -5)
                    } else {
                        Image("Incomplete")
                            .resizable()
                            .foregroundStyle(Color(AppConfig.main_bright_pink))
                            .frame(width: 40, height: 40)
//                            .padding(.trailing, -5)
                    }
                    Spacer()
                }
            }
            .padding(.bottom, 10)

            HStack {
                if exercise.exerciseVideoURL != "None" {
                    Button {
                        isPresentingVideo = true
                    } label: {
                        Image("GreenPlayButton")
                            .resizable()
                            .foregroundStyle(Color(AppConfig.main_bright_pink))
                            .frame(width: 35, height: 35)
                    }
                    .padding(.trailing, 10)
                }
                Button {
                    activeSheet = .history
                } label: {
                    Image("GreenFolder")
                        .resizable()
                        .foregroundStyle(Color(AppConfig.main_bright_pink))
                        .frame(width: 40, height: 35)
                }
                .padding(.trailing, 10)
                VStack {
                    if let rpe = exercise.rpe {
                        HStack {
                            Text("RPE: \(rpe)")
                                .bold()
                            Spacer()
                        }
                    }
                    
                    if let rest = exercise.rest {
                        HStack {
                            Text("REST: \(rest)")
                                .bold()
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            .padding(.bottom, 10)

            if exercise.exerciseDescription! != "None" && exercise.exerciseDescription! != "description of exercise" {
                HStack {
//                    ExpandableTextView(text: exercise.exerciseDescription!, previewCharacterLimit: 80)
                    Text(exercise.exerciseDescription!)
                        .font(.custom("Nexa-ExtraLight", size: 12))
                    Spacer()
                }
            }
        }
        .padding(CGFloat(padding))
//        .border(Color(AppConfig.main_neon_green))
        .clipped()
        .cornerRadius(20)
        .background(Color(AppConfig.main_light_blue))
        .fullScreenCover(isPresented: $isPresentingVideo) {
            if exercise.exerciseVideoURL != nil {
                VideoPlayerView(videoURL: URL(string: exercise.exerciseVideoURL!)!)
            }
        }
        .onAppear {
            loadExerciseHistory()
        }
        //, weight: "\(self.mostRecentSets[setIndexWrapper.id].weight)" ?? "", reps: self.mostRecentSets[setIndexWrapper.id].reps ?? 10, selectedUnit: self.mostRecentSets[setIndexWrapper.id].unit ?? "lbs")
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .dataEntry(let setIndexWrapper):
                if self.mostRecentSets[setIndexWrapper.id].weight != nil {
                    DataEntryView(weight: "\(String(self.mostRecentSets[setIndexWrapper.id].weight!))", selectedReps: self.mostRecentSets[setIndexWrapper.id].reps ?? 10, selectedUnit: self.mostRecentSets[setIndexWrapper.id].unit ?? "lbs", setIndex: setIndexWrapper.id) { setIndex, weight, reps, unit in
                        updateExerciseCompletion(setIndex: setIndex, weight: weight, reps: reps, unit: unit)
                    }
                    .transparentSheet()
                    .presentationBackground(.clear)
                } else {
                    DataEntryView(weight: "", selectedReps: self.mostRecentSets[setIndexWrapper.id].reps ?? 10, selectedUnit: self.mostRecentSets[setIndexWrapper.id].unit ?? "lbs", setIndex: setIndexWrapper.id) { setIndex, weight, reps, unit in
                        updateExerciseCompletion(setIndex: setIndex, weight: weight, reps: reps, unit: unit)
                    }
                    .transparentSheet()
                    .presentationBackground(.clear)
                }
                    
//                DataEntryView(weight: "\(String(self.mostRecentSets[setIndexWrapper.id].weight))", selectedReps: self.mostRecentSets[setIndexWrapper.id].reps ?? 10, selectedUnit: self.mostRecentSets[setIndexWrapper.id].unit ?? "lbs", setIndex: setIndexWrapper.id) { setIndex, weight, reps, unit in
//                    updateExerciseCompletion(setIndex: setIndex, weight: weight, reps: reps, unit: unit)
//                }
//                .transparentSheet()
//                .presentationBackground(.clear)
                
            case .history:
                ExerciseHistoryView(exerciseName: exercise.exerciseName!, exercise: exercise)
                    .transparentSheet()
                    .presentationBackground(.clear)
            }
        }
    }
}

enum SheetType: Identifiable {
    case dataEntry(SetIndexWrapper)
    case history
    
    var id: String {
        switch self {
        case .dataEntry(let setIndex):
            return "dataEntry_\(setIndex.id)"
        case .history:
            return "history"
        }
    }
}

//import SwiftUI
//
struct WeightEntryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .foregroundColor(Color(AppConfig.main_neon_green))
            .frame(width: 100, height: 20)
            .overlay(
                Rectangle()
                    .fill(Color(AppConfig.main_neon_green))
                    .frame(height: 2)
                    .offset(y: 10),
                alignment: .bottom
            )
    }
}

struct PlayButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

struct SetsButtonStyle: ButtonStyle {
    @Binding var selectedButtons: Set<Int>
    @Binding var isShowingEntryView: Bool
    @Binding var selectedSetIndex: SetIndexWrapper?
    let index: Int
    @Binding var isExerciseComplete: Bool
    @Binding var activeSheet: SheetType?
    var isSetComplete: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 30)
            .background((selectedButtons.contains(index) || isSetComplete) ? Color(AppConfig.main_dark_blue) : Color(.white))
            .foregroundColor((selectedButtons.contains(index) || isSetComplete) ? Color(.white): Color(AppConfig.main_dark_blue))
            .border(Color(AppConfig.main_dark_blue), width: 3)
            .cornerRadius(5)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .onTapGesture {
                selectedSetIndex = SetIndexWrapper(id: index)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    activeSheet = .dataEntry(selectedSetIndex!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isShowingEntryView = true
                }
                selectedButtons.insert(index)
            }
    }
}

struct SetIndexWrapper: Identifiable {
    let id: Int
}

struct TransparentSheetModifier: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            if let presentedController = controller.presentedViewController?.view.superview {
                presentedController.backgroundColor = UIColor.clear  // ✅ Make background transparent
            }
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

extension View {
    func transparentSheet() -> some View {
        self.background(TransparentSheetModifier())  // ✅ Apply transparency
    }
}
