//
//  AppDataStorage.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseCore
import Collections

class AppDataStorage: ObservableObject {
    @Published var activeUser: LocalUser
    @Published var activeWorkoutProgram: WorkoutProgram?
    @Published var loggedIn: Bool
    @Published var allExercises: [String:Exercise]
    
    @Published var totalProgramInstances: Int
    
    init() {
        self.activeUser = LocalUser.NullUser
        self.loggedIn = false
        self.activeWorkoutProgram = nil
        self.allExercises = [:]
        totalProgramInstances = 0
    }
    
    func calculateProgramCompletion() -> Double {
        var totalCompletedExercises: Int = 0
        
        if let program = self.activeWorkoutProgram {
            for week in program.trainingWeeks {
                for workout in week.workouts {
                    let exerciseIds = Set((workout.exercises + workout.warmups + workout.cooldowns).map { "\($0.exerciseID)_week\(week.weekNumber)_day\(workout.dayNumber)" })
                    let historyIds = Set(self.activeUser.exerciseHistory.map { $0.id })
                    
                    let completedCount = exerciseIds.intersection(historyIds).count
                    totalCompletedExercises += completedCount
                }
            }
        }
        
        return Double(totalCompletedExercises)/Double(totalProgramInstances)
    }
    
    func saveWorkoutSet(firebaseMangager: FirebaseManager, exerciseId: String, week: Int, day: Int, sets: [WorkoutSet]) {
        let exerciseRef = firebaseMangager.firestore.collection("users").document(self.activeUser.id)
            .collection("exerciseHistory").document(exerciseId)
        
        let setsData = sets.map { set in
            [
                "setIndex": set.setIndex,
                "weight": set.weight,
                "reps": set.reps,
                "unit": set.unit
            ]
        }
        let data: [String: Any] = [
            "week": week,
            "day": day,
            "sets": setsData,
            "completed": sets.allSatisfy { $0.weight != nil }, // Mark complete when all sets are logged
            "timestamp": Timestamp(date: Date())
        ]
        
        exerciseRef.setData(data, merge: true) { error in
            if let error = error {
                print("Error saving set: \(error.localizedDescription)")
            } else {
                print("Workout set saved successfully!")
            }
        }
    }
    
    func logExerciseData(firebaseManager: FirebaseManager, exerciseId: String, weekNumber: Int, dayNumber: Int, newSet: WorkoutSet, numSets: Int) -> Bool {
        let userRef = firebaseManager.firestore.collection("users").document(self.activeUser.id)
        var exerciseCompleted: Bool = false
        if numSets == 1 {
            exerciseCompleted = true
        }
        let instanceId: String = "\(exerciseId)_week\(weekNumber)_day\(dayNumber)"
        
        let historyRef = userRef
            .collection("exerciseHistory")
            .document(instanceId)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateCompleted = Date()
        
        let newSetData: [String: Any] = [
            "setIndex": newSet.setIndex,
            "weight": newSet.weight,
            "reps": newSet.reps,
            "unit": newSet.unit,
            "dateCompleted": dateCompleted,
            "completed": true
        ]
        
        // Modify local data
        if let index = activeUser.exerciseHistory.firstIndex(where: { $0.id == instanceId }) {
            // Safely retrieve and update the notes array
            activeUser.exerciseHistory[index].sets?.append(newSet)
            if (activeUser.exerciseHistory[index].sets?.count == numSets) {
                exerciseCompleted = true
                activeUser.exerciseHistory[index].completed = true
            }
            print("Updated set")
        } else {
            if numSets == 1 {
                exerciseCompleted = true
                let newHistoryInstance: ExerciseHistoryInstance = ExerciseHistoryInstance(id: instanceId, exerciseId: exerciseId, weekNumber: weekNumber, dayNumber: dayNumber, completed: true, dateCompleted: dateCompleted, sets: [newSet])
                activeUser.exerciseHistory.append(newHistoryInstance)
            } else {
                let newHistoryInstance: ExerciseHistoryInstance = ExerciseHistoryInstance(id: instanceId, exerciseId: exerciseId, weekNumber: weekNumber, dayNumber: dayNumber, completed: false, dateCompleted: dateCompleted, sets: [newSet])
                activeUser.exerciseHistory.append(newHistoryInstance)
            }
        }
        
        // Modify database data
        historyRef.getDocument { document, error in
            if let document = document, document.exists {
                var existingSets = document.data()?["sets"] as? [[String: Any]] ?? []
                
                // Prevent duplicate entries
                if !existingSets.contains(where: {
                    $0["setIndex"] as? Int == newSet.setIndex
                }) {
                    existingSets.append(newSetData)
                    
                    if exerciseCompleted {
                        historyRef.setData([
                            "sets": existingSets,
                            "completed": exerciseCompleted,
                            "dateCompleted": dateCompleted,
                            "exerciseId": exerciseId,
                            "weekNumber": weekNumber,
                            "dayNumber": dayNumber
                        ], merge: true) { error in
                            if let error = error {
                                print("Error updating history: \(error.localizedDescription)")
                            } else {
                                print("New set added to history for set \(newSet.setIndex)")
                            }
                        }
                    } else {
                        historyRef.setData([
                            "sets": existingSets,
                            "completed": exerciseCompleted,
                            "dateCompleted": dateCompleted,
                            "exerciseId": exerciseId,
                            "weekNumber": weekNumber,
                            "dayNumber": dayNumber
                        ], merge: true) { error in
                            if let error = error {
                                print("Error updating history: \(error.localizedDescription)")
                            } else {
                                print("New set added to history for set \(newSet.setIndex)")
                            }
                        }
                    }
                }
            } else {
                // First time logging this exercise
                if exerciseCompleted {
                    historyRef.setData([
                        "sets": [newSetData],
                        "completed": exerciseCompleted,
                        "dateCompleted": dateCompleted,
                        "exerciseId": exerciseId,
                        "weekNumber": weekNumber,
                        "dayNumber": dayNumber
                    ]) { error in
                        if let error = error {
                            print("Error creating history: \(error.localizedDescription)")
                        } else {
                            print("Exercise history created for first time.")
                        }
                    }
                } else {
                    historyRef.setData([
                        "sets": [newSetData],
                        "completed": exerciseCompleted,
                        "dateCompleted": dateCompleted,
                        "exerciseId": exerciseId,
                        "weekNumber": weekNumber,
                        "dayNumber": dayNumber
                    ]) { error in
                        if let error = error {
                            print("Error creating history: \(error.localizedDescription)")
                        } else {
                            print("Exercise history created for first time.")
                        }
                    }
                }
            }
        }
        return exerciseCompleted
    }
    
    func getExercisesDataSeperated(
        firebaseManager: FirebaseManager,
        exercises: [ProgramExercise],
        completion: @escaping ([[ProgramExercise]]) -> Void
    ) {
        let group = DispatchGroup()
        
        var exercisesToReturn: [[ProgramExercise]] = [[],[],[]]

        for exercise in exercises {
            let exerciseID = exercise.exerciseID
            group.enter()
            let exerciseInformation: Exercise? = self.allExercises[exerciseID]
            let newExercise: ProgramExercise = ProgramExercise(exerciseID: exerciseID, exerciseName: exerciseInformation?.exerciseName, exerciseDescription: exerciseInformation?.exerciseDescription, exerciseVideoURL: exerciseInformation?.exerciseVideoURL, exerciseType: exercise.exerciseType, reps: exercise.reps, sets: exercise.sets, rpe: exercise.rpe, rest: exercise.rest, exerciseGroupNumber: exercise.exerciseGroupNumber)
            
            if exercise.exerciseType == "warmup" {
                exercisesToReturn[0].append(newExercise)
            } else if exercise.exerciseType == "cooldown" {
                exercisesToReturn[2].append(newExercise)
            } else {
                exercisesToReturn[1].append(newExercise)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion(exercisesToReturn)
        }
    }
    
    func getObjectsContainingID<T: Identifiable>(
        from array: [T],
        containing searchString: String
    ) -> [T] where T.ID == String {
        return array.filter { $0.id.contains(searchString) }
    }
    
    func loginUser(firebaseManager: FirebaseManager, email: String, password: String) -> String? {
        var errMsg: String? = nil
        firebaseManager.auth.signIn(withEmail: email, password: password, completion: { result, error in
            errMsg = error?.localizedDescription
        })
        return errMsg
    }
    
    func registerUser(firebaseManager: FirebaseManager, email: String, password: String, name: String) -> String? {
        var errMsg: String? = nil
        firebaseManager.auth.createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                guard let uid = firebaseManager.auth.currentUser?.uid else {
                    return
                }
                let userData = ["email": email, "uid": uid, "name": name, "favorites": [], "exercises": []] as [String : Any]
                firebaseManager.firestore.collection("users")
                    .document(uid).setData(userData) { err in
                        if let err = err {
                            print(err)
                            return
                        }
                    }
            } else {
                errMsg = error?.localizedDescription
            }
            print("REGISTRATION ERROR: " + (error?.localizedDescription ?? "none"))
        }
        return errMsg
    }
    
    func setupApplication(firebaseManger: FirebaseManager) {
        inputLocalUser(firebaseManager: firebaseManger)
        loadProgram(firebaseManager: firebaseManger)
        loadExercises(firebaseManager: firebaseManger)
        print("program loaded")
    }
    
    func inputLocalUser(firebaseManager: FirebaseManager) {
        let user = firebaseManager.auth.currentUser
        guard let userUID = user?.uid else { return }

        let docRef = firebaseManager.firestore.collection("users").document(userUID)
        
        let dispatchGroup = DispatchGroup()
        var exerciseHistoryList: [ExerciseHistoryInstance] = []
        var userData: [String: Any]?
        var exerciseNotes: [ExerciseNote] = []

        // Step 1: Fetch User Document
        dispatchGroup.enter() // ENTER GROUP FOR USER DOCUMENT
        docRef.getDocument { (document, error) in
            if let document = document, document.exists, error == nil {
                userData = document.data() // Store user data
            } else {
                print("Error getting user document: \(error?.localizedDescription ?? "Unknown error")")
            }
            dispatchGroup.leave() // LEAVE GROUP
        }

        dispatchGroup.enter()
        docRef.collection("exerciseNotes").getDocuments { (noteCollection, error) in
            if let noteDocCollection = noteCollection, error == nil {
                for exerciseNote in noteDocCollection.documents {
                    if let note = exerciseNote.data()["note"] as? String {
                        exerciseNotes.append(ExerciseNote(exerciseId: exerciseNote.documentID , note: note))
                    }
                }
            }
            // Some users will have no notes
        }
        dispatchGroup.leave()
        print("Exercise notes: \(exerciseNotes.count)")
        

        // Step 2: Fetch Exercise History
        dispatchGroup.enter() // ENTER GROUP FOR EXERCISE HISTORY
        docRef.collection("exerciseHistory").getDocuments { (snapshot, error) in
            guard let snapshot = snapshot, error == nil else {
                print("Error fetching exercise history: \(error?.localizedDescription ?? "Unknown error")")
                dispatchGroup.leave()
                return
            }

            print("Number of exercise history documents: \(snapshot.documents.count)")
            
            for documentSnapshot in snapshot.documents {
                let documentData = documentSnapshot.data()
                let id = documentSnapshot.documentID
                let exerciseId = documentData["exerciseId"] as? String
                let dayNumber = documentData["dayNumber"] as? Int
                let weekNumber = documentData["weekNumber"] as? Int
                let completed = documentData["completed"] as? Bool
                let dateString = documentData["dateCompleted"] as? Timestamp
                let dateCompleted = dateString?.dateValue()
                
                var exerciseSets: [WorkoutSet] = []
                if let setsArray = documentData["sets"] as? [[String: Any]] {
                    for set in setsArray {
                        let reps = set["reps"] as? Int
                        let setIndex = set["setIndex"] as? Int ?? 0
                        let unit = set["unit"] as? String
                        let weight = set["weight"] as? Double
                        
                        let newWorkoutSet = WorkoutSet(setIndex: setIndex, weight: weight, reps: reps, unit: unit, completed: true)
                        exerciseSets.append(newWorkoutSet)
                    }
                }

                let newExerciseHistoryInstance = ExerciseHistoryInstance(
                    id: id,
                    exerciseId: exerciseId,
                    weekNumber: weekNumber,
                    dayNumber: dayNumber,
                    completed: completed,
                    dateCompleted: dateCompleted,
                    sets: exerciseSets
                )
                exerciseHistoryList.append(newExerciseHistoryInstance)
            }

            dispatchGroup.leave() // LEAVE GROUP
        }

        // Step 3: Once Both Queries Are Done, Update `activeUser`
        dispatchGroup.notify(queue: .main) {
            print("Both Firestore calls completed. Updating activeUser.")
            
            if let data = userData {
                let loggedInUser = LocalUser(
                    id: userUID,
                    name: data["name"] as? String ?? "User",
                    email: data["email"] as? String ?? "None",
                    exerciseHistory: exerciseHistoryList,
                    exerciseNotes: exerciseNotes
                )
                self.activeUser = loggedInUser
                print("activeUser is now set with full history")
            } else {
                print("Error: User data not available.")
            }
        }
    }

    
    func loadProgram(firebaseManager: FirebaseManager) {
        // set number of weeks
        let numWeeks = 1...14
        
        // load blank workout program
        let workoutProgram = WorkoutProgram(trainingWeeks: (1...14).map { week in
            WorkoutWeek(weekNumber: week, workouts: (1...5).map { Workout(dayNumber: $0) })
        })
        
        // fill workout program with data
        firebaseManager.firestore
            .collection("allProgramData2")
            .getDocuments {(snapshot, error) in
                 guard let snapshot = snapshot, error == nil else {
                  //handle error
                  return
                }
                print("Number of documents: \(snapshot.documents.count)")
                self.totalProgramInstances = snapshot.documents.count
                
                snapshot.documents.forEach({ (documentSnapshot) in
                    let documentData = documentSnapshot.data()
                    
                    let id = documentSnapshot.documentID
                    let weekNumber = documentData["weekNumber"] as? Int
                    let dayNumber = documentData["dayNumber"] as? Int
                    let exerciseType = documentData["exerciseType"] as? String
                    let exerciseID = documentData["exerciseID"] as? String
                    let reps = documentData["reps"] as? String
                    var sets = documentData["sets"] as? String
                    let rpe = documentData["rpe"] as? String
                    let rest = documentData["rest"] as? String
                    let exerciseGroupNumber = documentData["exerciseGroup"] as? Int
        
                    if sets == nil {
                        sets = "1"
                    }
                    var exerciseName: String = ""
                    var exerciseDescription: String = ""
                    var exerciseVideoURL: String = ""
                    
                    if let id = exerciseID {
                        let currExercise = self.allExercises[id]
                        exerciseName = currExercise?.exerciseName ?? ""
                        exerciseDescription = currExercise?.exerciseDescription ?? ""
                        exerciseVideoURL = currExercise?.exerciseVideoURL ?? ""
                    }
                    
                    let newExercise: ProgramExercise = ProgramExercise(exerciseID: exerciseID!, exerciseName: exerciseName, exerciseDescription: exerciseDescription, exerciseVideoURL: exerciseVideoURL, exerciseType: exerciseType, reps: reps, sets: sets, rpe: rpe, rest: rest, exerciseGroupNumber: exerciseGroupNumber)
                    
                    let weekIndex = weekNumber! - 1
                    let dayIndex = dayNumber! - 1
                    let workout = workoutProgram.trainingWeeks[weekIndex].workouts[dayIndex]
                    
                    // Add exercise to the correct category
                    switch exerciseType {
                    case "warmup":
                        workout.warmups.append(newExercise)
                    case "cooldown":
                        workout.cooldowns.append(newExercise)
                    default:
                        workout.focus = exerciseType
                        workout.exercises.append(newExercise)
                    }
                    
                    // Assign updated workout back to the structure
                    workoutProgram.trainingWeeks[weekIndex].workouts[dayIndex] = workout
                })
            }
        
        // sort workout program order
        for weekIndex in numWeeks {
            for dayIndex in 0..<5 {
                let workout = workoutProgram.trainingWeeks[weekIndex - 1].workouts[dayIndex]
                workout.warmups.sort { ($0.exerciseGroupNumber ?? Int.max) < ($1.exerciseGroupNumber ?? Int.max) }
                workout.cooldowns.sort { ($0.exerciseGroupNumber ?? Int.max) < ($1.exerciseGroupNumber ?? Int.max) }
                workout.exercises.sort { ($0.exerciseGroupNumber ?? Int.max) < ($1.exerciseGroupNumber ?? Int.max) }
                workoutProgram.trainingWeeks[weekIndex - 1].workouts[dayIndex] = workout
            }
        }
        
        
        
        // set workout program
        self.activeWorkoutProgram = workoutProgram
    }
    
    func loadExercises(firebaseManager: FirebaseManager) {
        firebaseManager.firestore
            .collection("exercises")
            .getDocuments {(snapshot, error) in
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
                snapshot.documents.forEach({ (documentSnapshot) in
                    let documentData = documentSnapshot.data()
                    let id = documentSnapshot.documentID
                    let exerciseName = documentData["exerciseName"] as? String
                    let exerciseDescription = documentData["exerciseDescription"] as? String
                    let exerciseVideoURL = documentData["exerciseVideoURL"] as? String
                    
                    let exercise = Exercise(exerciseID: id, exerciseName: exerciseName, exerciseDescription: exerciseDescription, exerciseVideoURL: exerciseVideoURL)
                    self.allExercises[id] = exercise
                })
            }
    }
    
    func getExerciseNote(exerciseId: String) -> String? {
        for exerciseNote in self.activeUser.exerciseNotes {
            if exerciseNote.exerciseId == exerciseId {
                return exerciseNote.note
            }
        }
        return nil
    }
    
    func setExerciseNotes(exerciseId: String, note: String) {
        for exerciseNote in self.activeUser.exerciseNotes {
            if exerciseNote.exerciseId == exerciseId {
                exerciseNote.setNote(note: note)
                return
            }
        }
        let newNote = ExerciseNote(exerciseId: exerciseId, note: note)
        newNote.setModified()
        self.activeUser.exerciseNotes.append(newNote)
    }
    
    func saveChangedExerciseNotes(firebaseManager: FirebaseManager) {
        // 1️⃣ Only proceed if something was modified
        guard activeUser.exerciseNotes.contains(where: \.modified) else { return }

        // 2️⃣ Get current user ID
        guard let userUID = firebaseManager.auth.currentUser?.uid else { return }
        var collection = firebaseManager.firestore
            .collection("users")
            .document(userUID)
            .collection("exerciseNotes")
                
        var numWritten: Int = 0
        for note in activeUser.exerciseNotes {
            if note.modified {
                collection.document(note.exerciseId).setData(["note": note.note])
                note.clearModified()
                numWritten += 1
            }
        }
        
        print("Num written: \(numWritten)")
        
    }

    
}
