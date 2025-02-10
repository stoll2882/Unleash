//
//  WorkoutSet.swift
//  Unleash
//
//  Created by Sam Toll on 2/8/25.
//

import Foundation

class WorkoutSet: Identifiable, ObservableObject {
    var id: String = UUID().uuidString
    var setIndex: Int
    var weight: Double?
    var reps: Int?
    var unit: String?
    var week: Int?
    var day: Int?
    var dateCompleted: Date?
    
    init(setIndex: Int) {
        self.setIndex = setIndex
        self.weight = nil
        self.reps = nil
        self.unit = nil
    }
    
    init(setIndex: Int, weight: Double?, reps: Int?, unit: String?) {
        self.setIndex = setIndex
        self.weight = weight
        self.reps = reps
        self.unit = unit
        self.week = nil
        self.day = nil
        self.dateCompleted = nil
    }
    
    init(setIndex: Int, weight: Double?, reps: Int?, unit: String?, week: Int?, day: Int?, dateCompleted: Date?) {
        self.setIndex = setIndex
        self.weight = weight
        self.reps = reps
        self.unit = unit
        self.week = week
        self.day = day
        self.dateCompleted = dateCompleted
    }
}

////
////  ExerciseBlockView.swift
////  Unleash
////
////  Created by Sam Toll on 2/4/25.
////
//
//import SwiftUI
//import FirebaseFirestore
//
//struct ExerciseBlockView: View {
//    @State var exercise: UserExercise
//    @State var isPresentingVideo: Bool = false
//    @EnvironmentObject var appDataStore: AppDataStorage
//    @EnvironmentObject var firebaseManager: FirebaseManager
//
//    @State private var selectedButtons: Set<Int> = []
//    @State private var isShowingEntryView: Bool = false
//    @State private var selectedSetIndex: SetIndexWrapper?
//    @State private var numberOfSets: Int?
//    @State private var sets: [WorkoutSet] = []
//    @State private var isExerciseComplete: Bool = false  // ✅ Store exercise completion
//    @State private var exerciseHistory: [WorkoutSet] = []
//    
//    var weekNumber: Int
//    var dayNumber: Int
//    
//    @State private var activeSheet: SheetType?
//
//    /// Loads exercise data from Firestore to check if it was previously completed
//    private func loadExerciseData() {
//        let userRef = firebaseManager.firestore.collection("users").document(appDataStore.activeUser.id)
//        let exerciseRef = firebaseManager.firestore.collection("exercisesLibrary").document(exercise.exerciseID)
//        let sessionRef = userRef.collection("exerciseHistory").document("\(exercise.exerciseID)_week\(weekNumber)_day\(dayNumber)")
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//
//        // ✅ Step 1: Fetch Exercise Details (ALWAYS visible)
//        exerciseRef.getDocument { exerciseDoc, exerciseError in
//            guard let exerciseData = exerciseDoc?.data(), exerciseError == nil else {
//                print("Error fetching exercise details: \(exerciseError?.localizedDescription ?? "Unknown error")")
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.exercise.exerciseDescription = exerciseData["description"] as? String ?? "No description available"
//                self.exercise.exerciseVideoURL = exerciseData["videoURL"] as? String ?? "None"
//                self.exercise.sets = exerciseData["sets"] as? String ?? "0"
//                self.exercise.rpe = exerciseData["rpe"] as? String ?? "N/A"
//                self.exercise.rest = exerciseData["rest"] as? String ?? "N/A"
//            }
//
//            // ✅ Step 2: Fetch User-Specific Exercise History
//            sessionRef.getDocument { sessionDoc, sessionError in
//                guard let sessionData = sessionDoc?.data(), sessionError == nil else {
//                    print("Error fetching user-specific exercise data: \(sessionError?.localizedDescription ?? "Unknown error")")
//
//                    // ✅ No history → Initialize blank sets
//                    DispatchQueue.main.async {
//                        self.initializeSets()
//                        self.isExerciseComplete = false
//                    }
//                    return
//                }
//
//                // ✅ Load saved sets
//                if let fetchedSets = sessionData["sets"] as? [[String: Any]] {
//                    let loadedSets = fetchedSets.compactMap { dict -> WorkoutSet? in
//                        guard let setIndex = dict["setIndex"] as? Int,
//                              let weight = dict["weight"] as? Double,
//                              let reps = dict["reps"] as? Int,
//                              let unit = dict["unit"] as? String,
//                              let week = dict["weekNumber"] as? Int,
//                              let day = dict["dayNumber"] as? Int,
//                              let dateString = dict["dateCompleted"] as? String,
//                              let dateCompleted = dateFormatter.date(from: dateString) else { return nil }
//                        return WorkoutSet(setIndex: setIndex, weight: weight, reps: reps, unit: unit, week: week, day: day, dateCompleted: dateCompleted)
//                    }
//
//                    DispatchQueue.main.async {
//                        // ✅ Ensure sets are not empty
//                        if loadedSets.isEmpty {
//                            self.initializeSets()
//                        }
//                        self.sets = loadedSets
//
//
//                        // ✅ Update completion status based on stored Firestore value OR check if all sets have weight
//                        if let firestoreCompleted = sessionData["completed"] as? Bool {
//                            self.isExerciseComplete = firestoreCompleted
//                        } else {
//                            self.isExerciseComplete = self.sets.allSatisfy { $0.weight != nil }
//                        }
//                    }
//                } else {
//                    // ✅ No history → Initialize blank sets
//                    DispatchQueue.main.async {
//                        self.initializeSets()
//                        self.isExerciseComplete = false
//                    }
//                }
//            }
//        }
//    }
//
//
////    private func loadExerciseData() {
////        let ref = firebaseManager.firestore.collection("users").document(appDataStore.activeUser.id)
////            .collection("exerciseHistory")
////            .document("\(exercise.exerciseID)_week\(weekNumber)_day\(dayNumber)")
////
////        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "yyyy-MM-dd"
////
////        ref.getDocument { document, error in
////            guard let data = document?.data(), error == nil else {
////                print("Error fetching exercise data: \(error?.localizedDescription ?? "Unknown error")")
////                return
////            }
////
////            if let fetchedSets = data["sets"] as? [[String: Any]] {
////                self.sets = fetchedSets.compactMap { dict in
////                    guard let setIndex = dict["setIndex"] as? Int,
////                          let weight = dict["weight"] as? Double,
////                          let reps = dict["reps"] as? Int,
////                          let unit = dict["unit"] as? String,
////                          let week = dict["weekNumber"] as? Int,
////                          let day = dict["dayNumber"] as? Int,
////                          let dateString = dict["dateCompleted"] as? String,
////                          let dateCompleted = dateFormatter.date(from: dateString) else { return nil }
////                    return WorkoutSet(setIndex: setIndex, weight: weight, reps: reps, unit: unit, week: week, day: day, dateCompleted: dateCompleted)
////                }
////            }
////            self.isExerciseComplete = data["completed"] as? Bool ?? false  // ✅ Load completion status
////        }
////    }
//
//    /// Checks if all sets have been logged and marks exercise as complete
//    private func updateExerciseCompletion() {
//        let completed = sets.allSatisfy { $0.weight != nil }  // ✅ Check if all sets are logged
//        self.isExerciseComplete = completed
//
//        // Save updated completion status to Firestore
//        let userRef = firebaseManager.firestore.collection("users").document(appDataStore.activeUser.id)
////            .collection("exerciseHistory")
////            .document("\(exercise.exerciseID)_week\(weekNumber)_day\(dayNumber)")
//        
//        let sessionRef = userRef
//            .collection("exerciseHistory")
//            .document("\(exercise.exerciseID)_week\(weekNumber)_day\(dayNumber)")
//
//        let fullHistoryRef = userRef
//            .collection("fullExerciseHistory")
//            .document(exercise.exerciseID)
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
////        let dateCompleted = dateFormatter.string(from: Date())
//        let dateCompleted = Date()
//
//        DispatchQueue.main.async {
//            let setsData = sets.map { [
//                "setIndex": $0.setIndex,
//                "weight": $0.weight,
//                "reps": $0.reps,
//                "unit": $0.unit,
//                "weekNumber": weekNumber,
//                "dayNumber": dayNumber,
//                "dateCompleted": dateCompleted
//            ]}
//            sessionRef.setData(["sets": setsData, "completed": completed, "dateCompleted": dateCompleted], merge: true) { error in
//                    if let error = error {
//                        print("Error updating session history: \(error.localizedDescription)")
//                    } else {
//                        print("Session history updated for Week \(weekNumber), Day \(dayNumber)")
//                    }
//                }
//
//            fullHistoryRef.getDocument { document, error in
//                if let document = document, document.exists {
//                    if var existingSets = document.data()?["sets"] as? [[String: Any]] {
//                        existingSets.append(contentsOf: setsData) // ✅ Append new session data
//                        fullHistoryRef.setData(["sets": existingSets], merge: true) { error in
//                            if let error = error {
//                                print("Error updating full history: \(error.localizedDescription)")
//                            } else {
//                                print("Full exercise history successfully updated.")
//                            }
//                        }
//                    }
//                } else {
//                    // ✅ If no history exists, create new entry
//                    fullHistoryRef.setData(["sets": setsData, "dateCompleted": dateCompleted]) { error in
//                        if let error = error {
//                            print("Error creating full history: \(error.localizedDescription)")
//                        } else {
//                            print("Full exercise history created.")
//                        }
//                    }
//                }
//            }
//            self.isExerciseComplete = completed
//        }
//    }
//    
//    private func loadFullExerciseHistory() {
//        let ref = firebaseManager.firestore.collection("users").document(appDataStore.activeUser.id)
//            .collection("fullExerciseHistory")
//            .document(exercise.exerciseID)
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//
//        ref.getDocument { document, error in
//            guard let data = document?.data(), error == nil else {
//                print("Error fetching full exercise history: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//
//            if let fetchedSets = data["sets"] as? [[String: Any]] {
//                self.exerciseHistory = fetchedSets.compactMap { dict in
//                    guard let setIndex = dict["setIndex"] as? Int,
//                          let weight = dict["weight"] as? Double,
//                          let reps = dict["reps"] as? Int,
//                          let unit = dict["unit"] as? String,
//                          let week = dict["weekNumber"] as? Int,
//                          let day = dict["dayNumber"] as? Int,
//                          let dateString = dict["dateCompleted"] as? String,
//                          let dateCompleted = dateFormatter.date(from: dateString) else { return nil }
//                    return WorkoutSet(setIndex: setIndex, weight: weight, reps: reps, unit: unit, week: week, day: day, dateCompleted: dateCompleted)
//                }
//            }
//        }
//    }
//
//    private func initializeSets() {
//        if let setsString = exercise.sets, let firstChar = setsString.first, let setsCount = Int(String(firstChar)) {
//            self.numberOfSets = setsCount
//            self.sets = (0..<setsCount).map { WorkoutSet(setIndex: $0) }
//        }
//    }
//    
//    private func buttonContent(for set: WorkoutSet, index: Int) -> some View {
//        HStack {
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
//        }
//    }
//    
//    var body: some View {
//        VStack {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(exercise.exerciseName)
//                        .font(.system(size: 22))
//                        .bold()
//                        .padding(.bottom, 5)
//
//                    if numberOfSets != nil && !sets.isEmpty {
//                        HStack {
//                            ForEach(0..<numberOfSets!, id: \.self) { index in
//                                let set = sets[index]
//                                Button {
////                                    selectedSetIndex = SetIndexWrapper(id: index)
//                                    selectedSetIndex = SetIndexWrapper(id: index)
////                                    activeSheet = nil
////                                    activeSheet = .dataEntry(selectedSetIndex!)
//                                } label: {
//                                    buttonContent(for: set, index: index)
//                                }
//                                .buttonStyle(SetsButtonStyle(selectedButtons: $selectedButtons, isShowingEntryView: $isShowingEntryView, selectedSetIndex: $selectedSetIndex, index: index, isExerciseComplete: $isExerciseComplete, activeSheet: $activeSheet))
//                                .disabled(isExerciseComplete)
//                            }
//                        }
//                    }
//                }
//                .padding(.trailing, 10)
//                Spacer()
//                VStack {
//                    if isExerciseComplete {
//                        Image("CheckMarkFill")
//                            .resizable()
//                            .foregroundStyle(Color(AppConfig.main_bright_pink))
//                            .frame(width: 60, height: 60)
//                            .padding(.trailing, -5)
//                    } else {
//                        Image("CheckMark")
//                            .resizable()
//                            .foregroundStyle(Color(AppConfig.main_bright_pink))
//                            .frame(width: 60, height: 60)
//                            .padding(.trailing, -5)
//                    }
//                    Spacer()
//                }
//            }
//            .padding(.bottom, 10)
//
//            HStack {
//                if exercise.exerciseVideoURL != "None" {
//                    Button {
//                        isPresentingVideo = true
//                    } label: {
//                        Image(systemName: "play.circle")
//                            .resizable()
//                            .foregroundStyle(Color(AppConfig.main_bright_pink))
//                            .frame(width: 35, height: 35)
//                    }
//                    .padding(.trailing, 10)
//                }
//                Button {
//                    loadFullExerciseHistory()
//                    activeSheet = .history
//                } label: {
//                    Image("Folder")
//                        .resizable()
//                        .foregroundStyle(Color(AppConfig.main_bright_pink))
//                        .frame(width: 40, height: 40)
//                }
//                .padding(.trailing, 10)
//                VStack {
//                    if let rpe = exercise.rpe {
//                        HStack {
//                            Text("RPE: \(rpe)")
//                                .bold()
//                            Spacer()
//                        }
//                    }
//                    
//                    if let rest = exercise.rest {
//                        HStack {
//                            Text("REST: \(rest)")
//                                .bold()
//                            Spacer()
//                        }
//                    }
//                }
//                Spacer()
//            }
//            .padding(.bottom, 10)
//
//            if exercise.exerciseDescription != "None" && exercise.exerciseDescription != "description of exercise" {
//                HStack {
//                    ExpandableTextView(text: exercise.exerciseDescription, previewCharacterLimit: 80)
//                    Spacer()
//                }
//            }
//        }
//        .padding(20)
//        .border(Color(AppConfig.main_neon_green))
//        .fullScreenCover(isPresented: $isPresentingVideo) {
//            VideoPlayerView(videoURL: URL(string: exercise.exerciseVideoURL)!)
//        }
//        .onAppear {
//            DispatchQueue.main.async {
//                initializeSets()
//                loadExerciseData()
//            }
//        }
//        .sheet(item: $activeSheet) { sheet in
//            switch sheet {
//            case .dataEntry(let setIndexWrapper):
//                DataEntryView(setIndex: setIndexWrapper.id) { setIndex, weight, reps, unit in
//                    sets[setIndex] = WorkoutSet(setIndex: setIndex, weight: weight, reps: reps, unit: unit)
//                    updateExerciseCompletion()
//                }
//                .transparentSheet()
//                .presentationBackground(.clear)
//                
//            case .history:
//                ExerciseHistoryView(exerciseName: exercise.exerciseName, history: exerciseHistory)
//                    .transparentSheet()
//                    .presentationBackground(.clear)
//            }
//        }
////        .sheet(item: $selectedSetIndex) { setIndexWrapper in
////            DataEntryView(setIndex: setIndexWrapper.id) { setIndex, weight, reps, unit in
////                sets[setIndex] = WorkoutSet(setIndex: setIndex, weight: weight, reps: reps, unit: unit)
////                updateExerciseCompletion()
////            }
////            .transparentSheet()
////            .presentationBackground(.clear)
////        }
//    }
//}
//
//enum SheetType: Identifiable {
//    case dataEntry(SetIndexWrapper)
//    case history
//    
//    var id: String {
//        switch self {
//        case .dataEntry(let setIndex):
//            return "dataEntry_\(setIndex.id)"
//        case .history:
//            return "history"
//        }
//    }
//}
//
////import SwiftUI
////
//struct WeightEntryButtonStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .bold()
//            .foregroundColor(Color(AppConfig.main_neon_green))
//            .frame(width: 100, height: 20)
//            .overlay(
//                Rectangle()
//                    .fill(Color(AppConfig.main_neon_green))
//                    .frame(height: 2)
//                    .offset(y: 10),
//                alignment: .bottom
//            )
//    }
//}
//
//struct PlayButtonStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding()
//            .opacity(configuration.isPressed ? 0.5 : 1)
//    }
//}
//
//struct SetsButtonStyle: ButtonStyle {
//    @Binding var selectedButtons: Set<Int>
//    @Binding var isShowingEntryView: Bool
//    @Binding var selectedSetIndex: SetIndexWrapper?
//    let index: Int
//    @Binding var isExerciseComplete: Bool
//    @Binding var activeSheet: SheetType?
//    
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding()
//            .frame(width: 80, height: 30)
//            .background((selectedButtons.contains(index) || isExerciseComplete) ? Color(AppConfig.main_orange) : Color(AppConfig.main_off_white))
//            .foregroundColor((selectedButtons.contains(index) || isExerciseComplete) ? Color(AppConfig.main_off_white) : Color(AppConfig.main_orange))
//            .border(Color(AppConfig.main_orange), width: 3)
//            .cornerRadius(5)
//            .opacity(configuration.isPressed ? 0.5 : 1)
//            .onTapGesture {
//                selectedSetIndex = SetIndexWrapper(id: index)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    activeSheet = .dataEntry(selectedSetIndex!)
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    isShowingEntryView = true
//                }
//                selectedButtons.insert(index)
//            }
//    }
//}
//
//struct SetIndexWrapper: Identifiable {
//    let id: Int
//}
//
//struct TransparentSheetModifier: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> UIViewController {
//        let controller = UIViewController()
//        DispatchQueue.main.async {
//            if let presentedController = controller.presentedViewController?.view.superview {
//                presentedController.backgroundColor = UIColor.clear  // ✅ Make background transparent
//            }
//        }
//        return controller
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//}
//
//extension View {
//    func transparentSheet() -> some View {
//        self.background(TransparentSheetModifier())  // ✅ Apply transparency
//    }
//}
