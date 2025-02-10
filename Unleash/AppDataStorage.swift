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
    
    init() {
        self.activeUser = LocalUser.NullUser
        self.loggedIn = false
        self.activeWorkoutProgram = nil
    }
    
//    private func loadExerciseData(firebaseManager: FirebaseManager, exercise: Exercise) {
//        let ref = firebaseManager.firestore.collection("users").document(self.activeUser.id)
//            .collection("exerciseHistory").document(exercise.exerciseID)
//
//        ref.getDocument { document, error in
//            guard let data = document?.data(), error == nil else {
//                print("Error fetching exercise data: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            if let fetchedSets = data["sets"] as? [[String: Any]] {
//                self.sets = fetchedSets.compactMap { dict in
//                    guard let setIndex = dict["setIndex"] as? Int,
//                          let weight = dict["weight"] as? Double,
//                          let reps = dict["reps"] as? Int,
//                          let unit = dict["unit"] as? String else { return nil }
//                    return WorkoutSet(setIndex: setIndex, weight: weight, reps: reps, unit: unit)
//                }
//            }
//            self.isExerciseComplete = data["completed"] as? Bool ?? false
//        }
//    }
    
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
    
    func logExerciseData(firebaseManager: FirebaseManager, exerciseID: String, weekNumber: Int, dayNumber: Int, weights: [Double]) {
        let weekDayCode = "\(weekNumber),\(dayNumber)"
        let newLog: [String: [String: [Double]]] = [exerciseID: [weekDayCode: weights]]
        
        let docRef = firebaseManager.firestore.collection("users")
            .document(self.activeUser.id)
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("Error fetching document: \(error!.localizedDescription)")
                return
            }
            
            var existingData: [String: [String: [Double]]] = [:]

            if let document = document, document.exists, let data = document.data() {
                // Extract existing Firestore data if present
                existingData = data["exercises"] as? [String: [String: [Double]]] ?? [:]
            }
            
            // Merge the new data into the existing structure
            if existingData[exerciseID] == nil {
                existingData[exerciseID] = [:]  // Initialize if outerKey does not exist
            }
            if existingData[exerciseID]![weekDayCode] == nil {
                existingData[exerciseID]![weekDayCode] = []  // Initialize if innerKey does not exist
            }
            existingData[exerciseID]![weekDayCode] = weights

            // Update Firestore with the modified or newly created data
            docRef.setData(["exercises": existingData], merge: true) { error in
                if let error = error {
                    print("Error updating document: \(error.localizedDescription)")
                } else {
                    print("Data successfully added to Firestore!")
                }
            }
        }
    }
    
    func getExercisesDataSeperated(
        firebaseManager: FirebaseManager,
        exercises: [Exercise],
        completion: @escaping ([[UserExercise]]) -> Void
    ) {
        let group = DispatchGroup()
        
        var exercisesToReturn: [[UserExercise]] = [[],[],[]]

        for exercise in exercises {
            let exerciseID = exercise.exerciseID
            group.enter()
            let docRef = firebaseManager.firestore.collection("exercises").document(exerciseID)
            
            docRef.getDocument { (document, error) in
                defer { group.leave() }
                
                if let error = error {
                    print("Error fetching exercise \(exerciseID): \(error.localizedDescription)")
                    return
                }
                
                if let document = document, document.exists, let data = document.data() {
                    let newExercise = UserExercise(
                        exerciseName: data["exerciseName"] as? String ?? "",
                        exerciseDescription: data["exerciseDescription"] as? String ?? "",
                        exerciseVideoURL: data["exerciseVideoURL"] as? String ?? "",
                        pastWeightScores: [self.activeUser.exercises[exerciseID]] as? [Double] ?? [],
                        exerciseID: exerciseID,
                        reps: exercise.reps,
                        sets: exercise.sets,
                        rpe: exercise.rpe,
                        rest: exercise.rest,
                        exerciseGroupNumber: exercise.exerciseGroupNumber,
                        exerciseType: exercise.exerciseType
                    )
                    
                    if exercise.exerciseType == "warmup" {
                        exercisesToReturn[0].append(newExercise)
                    } else if exercise.exerciseType == "cooldown" {
                        exercisesToReturn[2].append(newExercise)
                    } else {
                        exercisesToReturn[1].append(newExercise)
                    }
                }
            }
        }
        
        group.notify(queue: .main) {
            completion(exercisesToReturn)
        }
    }
    
    func getExercisesData(
        firebaseManager: FirebaseManager,
        exercises: [Exercise],
        completion: @escaping ([UserExercise]) -> Void
    ) {
        var exercisesToReturn: [UserExercise] = []
        let group = DispatchGroup()

        for exercise in exercises {
            let exerciseID = exercise.exerciseID
            group.enter()
            let docRef = firebaseManager.firestore.collection("exercises").document(exerciseID)
            
            docRef.getDocument { (document, error) in
                defer { group.leave() }
                
                if let error = error {
                    print("Error fetching exercise \(exerciseID): \(error.localizedDescription)")
                    return
                }
                
                if let document = document, document.exists, let data = document.data() {
                    let newExercise = UserExercise(
                        exerciseName: data["exerciseName"] as? String ?? "",
                        exerciseDescription: data["exerciseDescription"] as? String ?? "",
                        exerciseVideoURL: data["exerciseVideoURL"] as? String ?? "",
                        pastWeightScores: [self.activeUser.exercises[exerciseID]] as? [Double] ?? [],
                        exerciseID: exerciseID,
                        reps: exercise.reps,
                        sets: exercise.sets,
                        rpe: exercise.rpe,
                        rest: exercise.rest,
                        exerciseGroupNumber: exercise.exerciseGroupNumber,
                        exerciseType: exercise.exerciseType
                    )
                    exercisesToReturn.append(newExercise)
                }
            }
        }
        
        group.notify(queue: .main) {
            completion(exercisesToReturn)
        }
    }

    
//    func getExerciseData(
//        firebaseManager: FirebaseManager,
//        exerciseID: String,
//        reps: String,
//        sets: String,
//        rpe: String,
//        rest: String,
//        completion: @escaping (UserExercise?) -> Void
//    ) {
//        let docRef = firebaseManager.firestore.collection("exercises").document(exerciseID)
//        
//        docRef.getDocument { (document, error) in
//            guard error == nil else {
//                print("Error getting exercise: ", error?.localizedDescription ?? "Unknown error")
//                completion(nil)
//                return
//            }
//            
//            if let document = document, document.exists, let data = document.data() {
//                print("data: ", data)
//                let newExercise = UserExercise(
//                    exerciseName: data["exerciseName"] as? String ?? "",
//                    exerciseDescription: data["exerciseDescription"] as? String ?? "",
//                    exerciseVideoURL: data["exerciseVideoURL"] as? String ?? "",
//                    pastWeightScores: [self.activeUser.exercises[exerciseID]] as? [Double] ?? [],
//                    exerciseID: exerciseID,
//                    reps: reps,
//                    sets: sets,
//                    rpe: rpe,
//                    rest: rest
//                )
//                completion(newExercise)
//            } else {
//                completion(nil)
//            }
//        }
//    }
    
//    func getExerciseData(firebaseManager: FirebaseManager, exerciseID: String, reps: String, sets: String, rpe: String, rest: String) -> UserExercise? {
//        var newExercise: UserExercise? = nil
//        let docRef = firebaseManager.firestore
//            .collection("exercises").document(exerciseID)
//        docRef.getDocument { (document, error) in
//            guard error == nil else {
//                print("error getting user: ", error ?? "")
//                return
//            }
//            if let document = document, document.exists {
//                let data = document.data()
//                if let data = data {
//                    print("data: ", data)
//                    newExercise = UserExercise(exerciseName: data["exerciseName"] as? String ?? "", exerciseDescription: data["exerciseDescription"] as? String ?? "", exerciseVideoURL: data["exerciseVideoURL"] as? String ?? "", exerciseID: exerciseID, reps: reps, sets: sets, rpe: rpe, rest: rest)
//                }
//            }
//        }
//        return newExercise
//    }
    
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
        print("program loaded")
    }
    
    func inputLocalUser(firebaseManager: FirebaseManager) {
        let user = firebaseManager.auth.currentUser
        if user != nil {
            let uid = firebaseManager.auth.currentUser?.uid
            if let userUID = uid {
                let docRef = firebaseManager.firestore.collection("users").document(userUID)
                docRef.getDocument { (document, error) in
                    guard error == nil else {
                        print("error getting user: ", error ?? "")
                        return
                    }
                    if let document = document, document.exists {
                        let data = document.data()
                        if let data = data {
                            print("data: ", data)
                            let loggedInUser: LocalUser = LocalUser(id: userUID, name: data["name"] as? String ?? "User", email: data["email"] as? String ?? "None", exercises: data["exercises"] as? [String: [String: [Double]]] ?? [:])
                            self.activeUser = loggedInUser
                        }
                    }
                }
            }
        }
    }
    
    func loadProgram(firebaseManager: FirebaseManager) {
        var workoutWeek1 = WorkoutWeek(weekNumber: 1, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        var workoutWeek2 = WorkoutWeek(weekNumber: 2, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        var workoutWeek3 = WorkoutWeek(weekNumber: 3, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        var workoutWeek4 = WorkoutWeek(weekNumber: 4, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        var workoutWeek5 = WorkoutWeek(weekNumber: 5, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        var workoutWeek6 = WorkoutWeek(weekNumber: 6, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        var workoutWeek7 = WorkoutWeek(weekNumber: 7, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        var workoutWeek8 = WorkoutWeek(weekNumber: 8, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        var workoutWeek9 = WorkoutWeek(weekNumber: 9, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        var workoutWeek10 = WorkoutWeek(weekNumber: 10, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        var workoutWeek11 = WorkoutWeek(weekNumber: 11, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        var workoutWeek12 = WorkoutWeek(weekNumber: 12, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        var workoutWeek13 = WorkoutWeek(weekNumber: 13, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        var workoutWeek14 = WorkoutWeek(weekNumber: 14, workouts: [Workout(dayNumber: 1), Workout(dayNumber: 2), Workout(dayNumber: 3), Workout(dayNumber: 4), Workout(dayNumber: 5)])
        
//        var trainingBlock1 = TrainingBlock(blockNumber: 1, workoutWeeks: [workoutWeek1])
//        var trainingBlock2 = TrainingBlock(blockNumber: 2, workoutWeeks: [workoutWeek2, workoutWeek3, workoutWeek4])
//        var trainingBlock3 = TrainingBlock(blockNumber: 3, workoutWeeks: [workoutWeek5, workoutWeek6, workoutWeek7])
//        var trainingBlock4 = TrainingBlock(blockNumber: 4, workoutWeeks: [workoutWeek8, workoutWeek9, workoutWeek10])
//        var trainingBlock5 = TrainingBlock(blockNumber: 5, workoutWeeks: [workoutWeek11, workoutWeek12, workoutWeek13])
//        var trainingBlock6 = TrainingBlock(blockNumber: 6, workoutWeeks: [workoutWeek14])
                
        firebaseManager.firestore
            .collection("allProgramData2")
            .getDocuments {(snapshot, error) in
                 guard let snapshot = snapshot, error == nil else {
                  //handle error
                  return
                }
                print("Number of documents: \(snapshot.documents.count)")
                snapshot.documents.forEach({ (documentSnapshot) in
                    let documentData = documentSnapshot.data()
                    let weekNumber = documentData["weekNumber"] as? Int
                    let dayNumber = documentData["dayNumber"] as? Int
                    let exerciseType = documentData["exerciseType"] as? String
                    let exerciseID = documentData["exerciseID"] as? String
                    let reps = documentData["reps"] as? String
                    let sets = documentData["sets"] as? String
                    let rpe = documentData["rpe"] as? String
                    let rest = documentData["rest"] as? String
                    let exerciseGroupNumber = documentData["exerciseGroup"] as? Int
                    
                    let dayNumberIndex: Int = dayNumber! - 1
        
                    let new_exercise = Exercise(exerciseID: exerciseID!, exerciseType: exerciseType ?? nil, reps: reps ?? nil, sets: sets ?? nil, rpe: rpe ?? nil, rest: rest ?? nil, exerciseGroupNumber: exerciseGroupNumber ?? nil)
                    
                    if weekNumber == 1 {
                        if exerciseType == "warmup" {
                            workoutWeek1.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek1.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek1.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek1.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    } else if weekNumber == 2 {
                        if exerciseType == "warmup" {
                            workoutWeek2.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek2.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek2.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek2.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    } else if weekNumber == 3 {
                        if exerciseType == "warmup" {
                            workoutWeek3.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek3.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek3.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek3.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    } else if weekNumber == 4 {
                        if exerciseType == "warmup" {
                            workoutWeek4.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek4.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek4.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek4.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    } else if weekNumber == 5 {
                        if exerciseType == "warmup" {
                            workoutWeek5.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek5.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek5.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek5.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    } else if weekNumber == 6 {
                        if exerciseType == "warmup" {
                            workoutWeek6.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek6.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek6.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek6.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    } else if weekNumber == 7 {
                        if exerciseType == "warmup" {
                            workoutWeek7.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek7.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek7.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek7.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    } else if weekNumber == 8 {
                        if exerciseType == "warmup" {
                            workoutWeek8.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek8.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek8.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek8.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    } else if weekNumber == 9 {
                        if exerciseType == "warmup" {
                            workoutWeek9.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek9.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek9.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek9.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    } else if weekNumber == 10 {
                        if exerciseType == "warmup" {
                            workoutWeek10.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek10.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek10.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek10.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    } else if weekNumber == 11 {
                        if exerciseType == "warmup" {
                            workoutWeek11.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek11.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek11.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek11.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    } else if weekNumber == 12 {
                        if exerciseType == "warmup" {
                            workoutWeek12.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek12.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek12.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek12.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    } else if weekNumber == 13 {
                        if exerciseType == "warmup" {
                            workoutWeek13.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek13.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek13.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek13.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    } else if weekNumber == 14 {
                        if exerciseType == "warmup" {
                            workoutWeek14.workouts[dayNumberIndex].warmups.append(new_exercise)
                        } else if exerciseType == "cooldown" {
                            workoutWeek14.workouts[dayNumberIndex].cooldowns.append(new_exercise)
                        } else {
                            workoutWeek14.workouts[dayNumberIndex].focus = exerciseType
                            workoutWeek14.workouts[dayNumberIndex].exercises.append(new_exercise)
                        }
                    }
                })
            }
        self.activeWorkoutProgram = WorkoutProgram(trainingWeeks: [workoutWeek1, workoutWeek2, workoutWeek3, workoutWeek4, workoutWeek5, workoutWeek6, workoutWeek7, workoutWeek8, workoutWeek9, workoutWeek10, workoutWeek11, workoutWeek12, workoutWeek13, workoutWeek14])
    }
}
