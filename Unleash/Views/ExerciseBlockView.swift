//
//  ExerciseBlockView.swift
//  Unleash
//
//  Created by Sam Toll on 2/4/25.
//

import SwiftUI
import FirebaseFirestore

struct ExerciseBlockView: View {
    @State var exercise: UserExercise
    @State var isPresentingVideo: Bool = false
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager

    @State private var selectedButtons: Set<Int> = []
    @State private var isShowingEntryView: Bool = false
    @State private var selectedSetIndex: SetIndexWrapper?
    @State private var numberOfSets: Int?
    @State private var sets: [WorkoutSet] = []
    @State private var isExerciseComplete: Bool = false  // ✅ Store exercise completion
    
    var weekNumber: Int
    var dayNumber: Int
    
    @State private var activeSheet: SheetType?
    
    private func loadExerciseData() {
        let ref = firebaseManager.firestore.collection("users").document(appDataStore.activeUser.id)
            .collection("exerciseHistory")
            .document("\(exercise.exerciseID)_week\(weekNumber)_day\(dayNumber)")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        ref.getDocument { document, error in
            guard let data = document?.data(), error == nil else {
                print("Error fetching exercise data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let fetchedSets = data["sets"] as? [[String: Any]] {
                DispatchQueue.main.async {
                    if self.sets.isEmpty {
                        self.initializeSets()
                    }

                    for dict in fetchedSets {
                        if let setIndex = dict["setIndex"] as? Int, setIndex < self.sets.count {
                            let weight = dict["weight"] as? Double ?? self.sets[setIndex].weight
                            let reps = dict["reps"] as? Int ?? self.sets[setIndex].reps
                            let unit = dict["unit"] as? String ?? self.sets[setIndex].unit
                            let week = dict["weekNumber"] as? Int ?? weekNumber
                            let day = dict["dayNumber"] as? Int ?? dayNumber
                            let completed = dict["completed"] as? Bool ?? self.sets[setIndex].completed
                            let dateString = dict["dateCompleted"] as? String ?? "2000-01-01"
                            let dateCompleted = dateFormatter.date(from: dateString) ?? Date()

                            self.sets[setIndex] = WorkoutSet(
                                setIndex: setIndex,
                                weight: weight,
                                reps: reps,
                                unit: unit,
                                week: week,
                                day: day,
                                dateCompleted: dateCompleted,
                                completed: completed
                            )
                        }
                    }

                    self.isExerciseComplete = data["completed"] as? Bool ?? false
                }
            }
        }
    }

    // Checks if all sets have been logged and marks exercise as complete
    private func updateExerciseCompletion(setIndex: Int, weight: Double, reps: Int, unit: String) {
        sets[setIndex] = WorkoutSet(setIndex: setIndex, weight: weight, reps: reps, unit: unit)
        
        let completed = sets.allSatisfy { $0.weight != nil && $0.reps != nil }
        self.isExerciseComplete = completed

        let userRef = firebaseManager.firestore.collection("users").document(appDataStore.activeUser.id)
        
        let sessionRef = userRef
            .collection("exerciseHistory")
            .document("\(exercise.exerciseID)_week\(weekNumber)_day\(dayNumber)")

        let fullHistoryRef = userRef
            .collection("fullExerciseHistory")
            .document(exercise.exerciseID)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateCompleted = Date()
        
        DispatchQueue.main.async {
            let setsData = sets
                .filter { $0.weight != nil && $0.reps != nil }
                .map { [
                    "setIndex": $0.setIndex,
                    "weight": $0.weight,
                    "reps": $0.reps,
                    "unit": $0.unit,
                    "weekNumber": weekNumber,
                    "dayNumber": dayNumber,
                    "completed": true,
                    "dateCompleted": dateCompleted
                ]}
            sessionRef.setData(["sets": setsData, "completed": completed, "dateCompleted": dateCompleted], merge: true) { error in
                    if let error = error {
                        print("Error updating session history: \(error.localizedDescription)")
                    } else {
                        print("Session history updated for Week \(weekNumber), Day \(dayNumber)")
                    }
                }
            
            let newSetData: [String: Any] = [
                    "setIndex": setIndex,
                    "weight": weight,
                    "reps": reps,
                    "unit": unit,
                    "weekNumber": weekNumber,
                    "dayNumber": dayNumber,
                    "completed": true,
                    "dateCompleted": dateCompleted
                ]
            fullHistoryRef.getDocument { document, error in
                if let document = document, document.exists {
                    var existingSets = document.data()?["sets"] as? [[String: Any]] ?? []
                    
                    // ✅ Prevent duplicate entries
                    if !existingSets.contains(where: {
                        $0["setIndex"] as? Int == setIndex &&
                        $0["weekNumber"] as? Int == weekNumber &&
                        $0["dayNumber"] as? Int == dayNumber
                    }) {
                        existingSets.append(newSetData)
                        
                        fullHistoryRef.setData(["sets": existingSets], merge: true) { error in
                            if let error = error {
                                print("Error updating full history: \(error.localizedDescription)")
                            } else {
                                print("New set added to full history for set \(setIndex)")
                            }
                        }
                    }
                } else {
                    // ✅ First time logging this exercise
                    fullHistoryRef.setData(["sets": [newSetData]]) { error in
                        if let error = error {
                            print("Error creating full history: \(error.localizedDescription)")
                        } else {
                            print("Full exercise history created for first time.")
                        }
                    }
                }
            }
//            fullHistoryRef.getDocument { document, error in
//                if let document = document, document.exists {
//                    if var existingSets = document.data()?["sets"] as? [[String: Any]] {
//                        existingSets.append(contentsOf: setsData)
//                        fullHistoryRef.setData(["sets": existingSets], merge: true) { error in
//                            if let error = error {
//                                print("Error updating full history: \(error.localizedDescription)")
//                            } else {
//                                print("Full exercise history successfully updated.")
//                            }
//                        }
//                    }
//                } else {
//                    fullHistoryRef.setData(["sets": setsData, "dateCompleted": dateCompleted]) { error in
//                        if let error = error {
//                            print("Error creating full history: \(error.localizedDescription)")
//                        } else {
//                            print("Full exercise history created.")
//                        }
//                    }
//                }
//            }
            self.isExerciseComplete = completed
        }
    }
    
    private func initializeSets() {
        if let setsString = exercise.sets, let firstChar = setsString.first, let setsCount = Int(String(firstChar)) {
            self.numberOfSets = setsCount
            self.sets = (0..<setsCount).map { WorkoutSet(setIndex: $0) }
        }
    }
    
    private func buttonContent(for set: WorkoutSet, index: Int) -> some View {
        
        HStack {
            if set.completed {
                Text("\(set.reps ?? 0) | \(set.weight ?? 0, specifier: "%.1f") \(set.unit ?? "")")
                    .foregroundColor((selectedButtons.contains(index) || isExerciseComplete) ? Color(AppConfig.main_off_white) : Color(AppConfig.main_orange))
                    .bold()
                    .font(.system(size: 8))
            } else {
                Text("\(self.exercise.reps!)")
                    .foregroundColor((selectedButtons.contains(index) || isExerciseComplete) ? Color(AppConfig.main_off_white) : Color(AppConfig.main_orange))
                    .bold()
                    .font(.system(size: 8))
            }
//            if let weight = set.weight {
//                Text("\(set.reps ?? 0) | \(set.weight ?? 0, specifier: "%.1f") \(set.unit ?? "")")
//                    .foregroundColor((selectedButtons.contains(index) || isExerciseComplete) ? Color(AppConfig.main_off_white) : Color(AppConfig.main_orange))
//                    .bold()
//                    .font(.system(size: 8))
//            } else {
//                Text("\(self.exercise.reps!)")
//                    .foregroundColor((selectedButtons.contains(index) || isExerciseComplete) ? Color(AppConfig.main_off_white) : Color(AppConfig.main_orange))
//                    .bold()
//                    .font(.system(size: 8))
//            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(exercise.exerciseName)
                        .font(.system(size: 22))
                        .bold()
                        .padding(.bottom, 5)

                    if numberOfSets != nil && sets.count == numberOfSets {
                        HStack {
                            ForEach(0..<numberOfSets!, id: \.self) { index in
                                let set = sets[index]
                                Button {
                                    selectedSetIndex = SetIndexWrapper(id: index)
                                } label: {
                                    HStack {
                                        if set.completed {
                                            Text("\(set.reps ?? 0) | \(set.weight ?? 0, specifier: "%.1f") \(set.unit ?? "")")
                                                .foregroundColor((selectedButtons.contains(index) || isExerciseComplete) ? Color(AppConfig.main_off_white) : Color(AppConfig.main_orange))
                                                .bold()
                                                .font(.system(size: 8))
                                        } else {
                                            Text("\(self.exercise.reps!)")
                                                .foregroundColor((selectedButtons.contains(index) || isExerciseComplete) ? Color(AppConfig.main_off_white) : Color(AppConfig.main_orange))
                                                .bold()
                                                .font(.system(size: 8))
                                        }
                            //            if let weight = set.weight {
                            //                Text("\(set.reps ?? 0) | \(set.weight ?? 0, specifier: "%.1f") \(set.unit ?? "")")
                            //                    .foregroundColor((selectedButtons.contains(index) || isExerciseComplete) ? Color(AppConfig.main_off_white) : Color(AppConfig.main_orange))
                            //                    .bold()
                            //                    .font(.system(size: 8))
                            //            } else {
                            //                Text("\(self.exercise.reps!)")
                            //                    .foregroundColor((selectedButtons.contains(index) || isExerciseComplete) ? Color(AppConfig.main_off_white) : Color(AppConfig.main_orange))
                            //                    .bold()
                            //                    .font(.system(size: 8))
                            //            }
                                    }
                                }
                                .buttonStyle(SetsButtonStyle(selectedButtons: $selectedButtons, isShowingEntryView: $isShowingEntryView, selectedSetIndex: $selectedSetIndex, index: index, isExerciseComplete: $isExerciseComplete, activeSheet: $activeSheet, isSetComplete: sets[index].completed))
                                .disabled(isExerciseComplete)
                            }
                        }
                    }
                }
                .padding(.trailing, 10)
                Spacer()
                VStack {
                    if isExerciseComplete {
                        Image("CheckMarkFill")
                            .resizable()
                            .foregroundStyle(Color(AppConfig.main_bright_pink))
                            .frame(width: 60, height: 60)
                            .padding(.trailing, -5)
                    } else {
                        Image("CheckMark")
                            .resizable()
                            .foregroundStyle(Color(AppConfig.main_bright_pink))
                            .frame(width: 60, height: 60)
                            .padding(.trailing, -5)
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
                        Image(systemName: "play.circle")
                            .resizable()
                            .foregroundStyle(Color(AppConfig.main_bright_pink))
                            .frame(width: 35, height: 35)
                    }
                    .padding(.trailing, 10)
                }
                Button {
                    activeSheet = .history
                } label: {
                    Image("Folder")
                        .resizable()
                        .foregroundStyle(Color(AppConfig.main_bright_pink))
                        .frame(width: 40, height: 40)
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

            if exercise.exerciseDescription != "None" && exercise.exerciseDescription != "description of exercise" {
                HStack {
                    ExpandableTextView(text: exercise.exerciseDescription, previewCharacterLimit: 80)
                    Spacer()
                }
            }
        }
        .padding(20)
        .border(Color(AppConfig.main_neon_green))
        .fullScreenCover(isPresented: $isPresentingVideo) {
            VideoPlayerView(videoURL: URL(string: exercise.exerciseVideoURL)!)
        }
        .onAppear {
            initializeSets()
            loadExerciseData()
        }
        .sheet(item: $activeSheet, onDismiss: {
            loadExerciseData()  // ✅ Reload exercise completion status after closing the history sheet
        }) { sheet in
            switch sheet {
            case .dataEntry(let setIndexWrapper):
                DataEntryView(setIndex: setIndexWrapper.id) { setIndex, weight, reps, unit in
//                    sets[setIndex] = WorkoutSet(setIndex: setIndex, weight: weight, reps: reps, unit: unit)
                    updateExerciseCompletion(setIndex: setIndex, weight: weight, reps: reps, unit: unit)
                }
                .transparentSheet()
                .presentationBackground(.clear)
                
            case .history:
                ExerciseHistoryView(exerciseName: exercise.exerciseName, exercise: exercise)
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
            .padding()
            .frame(width: 80, height: 30)
            .background((selectedButtons.contains(index) || isSetComplete) ? Color(AppConfig.main_orange) : Color(AppConfig.main_off_white))
            .foregroundColor((selectedButtons.contains(index) || isSetComplete) ? Color(AppConfig.main_off_white) : Color(AppConfig.main_orange))
            .border(Color(AppConfig.main_orange), width: 3)
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
