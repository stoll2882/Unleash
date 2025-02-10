////import SwiftUI
////import AVKit
////
////// MARK: - Data Models for the Workout Program
////struct WorkoutWeekK: Identifiable {
////    let id = UUID()
////    let weekName: String
////    let days: [WorkoutProgram]
////}
////
////struct WorkoutProgram: Identifiable {
////    let id = UUID()
////    let day: String
////    let warmups: [Exercise]
////    let workouts: [Exercise]
////    let cooldowns: [Exercise]
////}
////
////struct ExerciseK: Codable, Identifiable {
////    var id: UUID?
////    let exercise: String
////    let reps: String
////    let sets: String
////    let rpe: String
////    let rest: String
////
////    // Computed property to generate the video URL
////    var videoURL: URL? {
////        return Bundle.main.url(forResource: exercise, withExtension: "mp4")
////    }
////}
////
//func loadWorkoutWeeks() -> [WorkoutWeek] {
//    // Example for Week 1, Day 1
//    let baseline_week1_exercises = [
//        WorkoutProgram(
//            day: "Day 1",
//            warmups: [
//                Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//            Exercise(exercise: "Max Standing Vertical Jump Test", reps: "1", sets: "1", rpe: "10", rest: "120-180s"),
//            Exercise(exercise: "Max Standing Broad Jump Test", reps: "1", sets: "1", rpe: "10", rest: "120-180s"),
//            Exercise(exercise: "Barbell Deadlift", reps: "5", sets: "1", rpe: "10", rest: "120-180s"),
//            Exercise(exercise: "Max Front Plank", reps: "1", sets: "1", rpe: "10", rest: "30s"),
//                        ],
//                        cooldowns: [
//            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 2",
//            warmups: [
//            Exercise(exercise: "SMR Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Quadruped T-Spine Rotation", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Band Pull Aparts", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Shoulder Press", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "TRX Row", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Standing Med Ball Chest Pass", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//            Exercise(exercise: "Pull-Ups", reps: "AMRAP", sets: "1", rpe: "10", rest: "120-180s"),
//            Exercise(exercise: "Push-Up", reps: "AMRAP", sets: "1", rpe: "10", rest: "120-180s"),
//            Exercise(exercise: "TRX Bicep Curl", reps: "12", sets: "3", rpe: "6-7", rest: "<30s"),
//            Exercise(exercise: "TRX Tricep Extension", reps: "6-7", sets: "3", rpe: "10", rest: "<30s"),
//            Exercise(exercise: "TRX Y", reps: "12", sets: "3", rpe: "6-7", rest: "<30s"),
//            Exercise(exercise: "Dumbbell Half Kneeling Single Arm Press", reps: "12 ES", sets: "3", rpe: "6-7", rest: "<30s"),
//            Exercise(exercise: "Butterfly Sit-Up", reps: "12", sets: "3", rpe: "6-7", rest: "<30s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Wall Shoulder Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Posterior Capsule Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Half Kneeling Lat Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "SMR Angels", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "SMR Swimmers", reps: "10", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 3",
//            warmups: [
//            Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            /*Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")*/,
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//            Exercise(exercise: "Walking", reps: "40-45 MIN", sets: "1", rpe: "8", rest: "nan"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        WorkoutProgram(
//            day: "Day 4",
//            warmups: [
//        Exercise(exercise: "SMR Quads", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//        /*Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")*/,
//        Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Leg Swings", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Squat", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Barbell Back Squat", reps: "5", sets: "5", rpe: "10", rest: "120s-180s"),
//        Exercise(exercise: "Barbell Hip Thrust", reps: "5", sets: "3-5", rpe: "10", rest: "120-180s"),
//        Exercise(exercise: "Assisted Single Leg DB or KB RDL", reps: "12 EL", sets: "3", rpe: "6-7", rest: "60-120s"),
//        Exercise(exercise: "Lateral Lunge", reps: "12", sets: "3", rpe: "6-7", rest: "30s"),
//        Exercise(exercise: "Side Plank Clam Shell", reps: "12 ES", sets: "3", rpe: "6-7", rest: "30-60s"),
//                        ],
//                        cooldowns: [
//        Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Seated Runners Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Downward Dog", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//        ]),
//       
//        WorkoutProgram(
//            day: "Day 5",
//            warmups: [
//        Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//        /*Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")*/,
//        Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Squat", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Box Jump", reps: "12", sets: "3", rpe: "6-7", rest: "30s"),
//        Exercise(exercise: "Speed Box Toe Touches", reps: "12", sets: "3", rpe: "6-7", rest: "30s"),
//        Exercise(exercise: "Single Leg MB Slam", reps: "6 EL", sets: "3", rpe: "6-7", rest: "60-120s"),
//        Exercise(exercise: "Weight Jacks", reps: "12", sets: "3", rpe: "6-7", rest: "30s-60s"),
//        Exercise(exercise: "Side Plank", reps: "30 SEC ES", sets: "3", rpe: "6-7", rest: "30-60s"),
//        Exercise(exercise: "Plank Body Saw", reps: "12", sets: "3", rpe: "6-7", rest: "60s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//    
//        ])
//        ]
//
//// Weeks 2-4
//let week_2_4_exercises = [
//    WorkoutProgram(
//        day: "Day 1",
//        warmups: [
//            Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//        /*Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")*/,
//        Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//        ],
//                    workouts: [
//        Exercise(exercise: "Depth Drop", reps: "5", sets: "3", rpe: "5", rest: "60s"),
//        Exercise(exercise: "Banded Assisted Pogos", reps: "15", sets: "3", rpe: "10", rest: "60-120s"),
//        Exercise(exercise: "Dumbbell RDL", reps: "15", sets: "3", rpe: "7.5", rest: "30s"),
//        Exercise(exercise: "Broad Jumps", reps: "5", sets: "3", rpe: "10", rest: "60-90s"),
//        Exercise(exercise: "Goblet Squat to Box", reps: "15", sets: "3", rpe: "7.5", rest: "30s"),
//        Exercise(exercise: "Box Squat Jumps", reps: "5", sets: "3", rpe: "10", rest: "60-90s"),
//        Exercise(exercise: "Half Kneeling Cable Rotations", reps: "10 ES", sets: "3", rpe: "5", rest: "30s"),
//                    ],
//                    cooldowns: [
//                        Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//    ]),
//    
//    WorkoutProgram(
//        day: "Day 2",
//        warmups: [
//            Exercise(exercise: "SMR Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Quadruped T-Spine Rotation", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Band Pull Aparts", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Shoulder Press", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "TRX Row", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Standing Med Ball Chest Pass", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//        ],
//                    workouts: [
//        Exercise(exercise: "Pull-Ups", reps: "AMRAP", sets: "3", rpe: "9-10", rest: "60-120s"),
//        Exercise(exercise: "Push-Up", reps: "AMRAP", sets: "3", rpe: "91-", rest: "<30s"),
//        Exercise(exercise: "Seated Cable Row", reps: "15", sets: "3", rpe: "7.5", rest: "<30s"),
//        Exercise(exercise: "Dumbbell Bicep Curl", reps: "15", sets: "3", rpe: "7.5", rest: "<30s"),
//        Exercise(exercise: "Dumbbell Skull Crusher", reps: "15", sets: "3", rpe: "7.5", rest: "<30s"),
//        Exercise(exercise: "Dumbbell Seated Lateral Raise", reps: "15", sets: "3", rpe: "7.5", rest: "<30s"),
//        Exercise(exercise: "Dumbbell Push Press", reps: "15", sets: "3", rpe: "7.5", rest: "<30s"),
//        Exercise(exercise: "Plank Walkout", reps: "15", sets: "3", rpe: "5", rest: "<30s"),
//                    ],
//                    cooldowns: [
//                        Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Wall Shoulder Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Posterior Capsule Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Half Kneeling Lat Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "SMR Angels", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "SMR Swimmers", reps: "10", sets: "1", rpe: "5", rest: "<30s")
//    ]),
//    
//    WorkoutProgram(
//        day: "Day 3",
//        warmups: [
//            Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//        /*Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")*/,
//        Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//        ],
//                    workouts: [
//        Exercise(exercise: "Walking", reps: "25-30 MIN", sets: "1", rpe: "5-7", rest: "0"),
//                    ],
//                    cooldowns: [
//                        Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//    ]),
//    
//    WorkoutProgram(
//        day: "Day 4",
//        warmups: [
//            Exercise(exercise: "SMR Quads", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            /*Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")*/,
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Leg Swings", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//        ],
//                    workouts: [
//    Exercise(exercise: "Barbell Back Squat", reps: "15", sets: "3", rpe: "7.5", rest: "60s"),
//    Exercise(exercise: "Dumbbell Split Squat", reps: "15 EL", sets: "3", rpe: "7.5", rest: "60-120s"),
//    Exercise(exercise: "Barbell Hip Thrust", reps: "15", sets: "3", rpe: "7.5", rest: "60s"),
//    Exercise(exercise: "Dumbbell Calf Raises", reps: "15", sets: "3", rpe: "7.5", rest: "60-120s"),
//    Exercise(exercise: "Copenhagen Plank", reps: "30 SEC ES", sets: "3", rpe: "8", rest: "30s"),
//    Exercise(exercise: "Hip Airplanes", reps: "15 EL", sets: "3", rpe: "5", rest: "30s"),
//                    ],
//                    cooldowns: [
//                        Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Seated Runners Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Downward Dog", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//    ]),
//    
//    WorkoutProgram(
//        day: "Day 5",
//        warmups: [
//            Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//        /*Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")*/,
//        Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//        Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//        ],
//                    workouts: [
//    Exercise(exercise: "Landmine Thruster", reps: "15", sets: "3", rpe: "7", rest: "60s"),
//    Exercise(exercise: "Ice Skaters", reps: "16", sets: "3", rpe: "9", rest: "30s"),
//    Exercise(exercise: "Step-Up Lunge Jumps", reps: "30", sets: "3", rpe: "9", rest: "30s"),
//    Exercise(exercise: "Standing Med Ball Chest Pass", reps: "15", sets: "3", rpe: "7", rest: "30-60s"),
//    Exercise(exercise: "Med Ball Twist Throw", reps: "10 ES", sets: "3", rpe: "9", rest: "60-120s"),
//    Exercise(exercise: "Farmer Walks", reps: "30 SEC ES", sets: "3", rpe: "7.5", rest: "30s"),
//    Exercise(exercise: "Plank Weight Slide", reps: "45 SEC", sets: "3", rpe: "7.5", rest: "60s"),
//                    ],
//                    cooldowns: [
//                        Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                        Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//])
//    ]
//    // WEEK 5-7 Exercises
//    let week_5_7_exercises = [
//        WorkoutProgram(
//            day: "Day 1",
//            warmups: [
////                Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            /*Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")*/,
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Depth Drop Jump", reps: "5", sets: "3", rpe: "8", rest: "60s"),
//        Exercise(exercise: "Pogos", reps: "10", sets: "3", rpe: "10", rest: "60-120s"),
//        Exercise(exercise: "Barbell RDL", reps: "12", sets: "3", rpe: "8", rest: "30s"),
//        Exercise(exercise: "Broad Jumps", reps: "5", sets: "3", rpe: "10", rest: "60-90s"),
//        Exercise(exercise: "Goblet Squat", reps: "12", sets: "3", rpe: "8", rest: "30s"),
//        Exercise(exercise: "Box Jump", reps: "5", sets: "3", rpe: "10", rest: "60-90s"),
//        Exercise(exercise: "Half Kneeling Cable Wood Chop", reps: "10 ES", sets: "3", rpe: "6", rest: "30s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 2",
//            warmups: [
//                Exercise(exercise: "SMR Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Quadruped T-Spine Rotation", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Band Pull Aparts", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Shoulder Press", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "TRX Row", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Standing Med Ball Chest Pass", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Band Assisted Pull-Up", reps: "12", sets: "3", rpe: "8", rest: "60-120s"),
//        Exercise(exercise: "Hand Release Push-Up", reps: "12", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Seated Cable Wide Grip Row", reps: "12", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "EZ Bar Curls", reps: "12", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "EZ Bar Skull Crushers", reps: "12", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Dumbbell 3 Position Raise", reps: "6", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Barbell Push Press", reps: "12", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Sprinter Sit-Up", reps: "12 ES", sets: "3", rpe: "5", rest: "<30s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Wall Shoulder Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Posterior Capsule Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Half Kneeling Lat Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "SMR Angels", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "SMR Swimmers", reps: "10", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 3",
//            warmups: [
////                Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Walking", reps: "30-35 MIN", sets: "1", rpe: "6-7", rest: "0"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 4",
//            warmups: [
//                Exercise(exercise: "SMR Quads", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Leg Swings", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Squat", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Trap Bar Deadlift", reps: "12", sets: "3", rpe: "8", rest: "60s"),
//        Exercise(exercise: "Assisted KB Single Leg RDL", reps: " 12 EL", sets: "3", rpe: "8", rest: "60-120s"),
//        Exercise(exercise: "Cable Pull Through", reps: "12", sets: "3", rpe: "8", rest: "60s"),
//        Exercise(exercise: "Cable Calf Raises", reps: "12", sets: "3", rpe: "8", rest: "60-120s"),
//        Exercise(exercise: "Copenhagen Hip Drop Plank", reps: "12 EL", sets: "3", rpe: "8", rest: "30s"),
//        Exercise(exercise: "KB Front Rack Lateral Walk", reps: "12 EL", sets: "3", rpe: "8", rest: "30s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Runners Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Downward Dog", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 5",
//            warmups: [
////                Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Plate Snatch to Heel Tap", reps: "12", sets: "3", rpe: "7-8", rest: "60s"),
//        Exercise(exercise: "Med Ball Ice Skaters", reps: "12", sets: "3", rpe: "9", rest: "30s"),
//        Exercise(exercise: "Step-Up Sprinter Jumps", reps: "10 EL", sets: "3", rpe: "9", rest: "30s"),
//        Exercise(exercise: "Plyo Push-Up", reps: "12", sets: "3", rpe: "9", rest: "30s-60s"),
//        Exercise(exercise: "Split Stance Med Ball Twist Throw", reps: "10 ES", sets: "3", rpe: "7", rest: "60-120s"),
//        Exercise(exercise: "Chaos Suitcase Carry", reps: "30 SEC ES", sets: "3", rpe: "8", rest: "30s"),
//        Exercise(exercise: "Plank Body Saw", reps: "12", sets: "3", rpe: "8", rest: "60s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//        ])
//        ]
//
//    // WEEK 8-10 Exercises
//    let week_8_10_exercises = [
//        WorkoutProgram(
//            day: "Day 1",
//            warmups: [
////            Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Depth Drop Jump to Box", reps: "5", sets: "3", rpe: "10", rest: "60s"),
//        Exercise(exercise: "Single Leg Pogos", reps: "5 EL", sets: "3", rpe: "10", rest: "60-120s"),
//        Exercise(exercise: "Barbell Deadlift", reps: "10", sets: "3", rpe: "8", rest: "30s"),
//        Exercise(exercise: "Broad Jumps", reps: "5", sets: "3", rpe: "10", rest: "60-90s"),
//        Exercise(exercise: "Zercher Squat", reps: "10", sets: "3", rpe: "8", rest: "30s"),
//        Exercise(exercise: "TRX Jump Squats", reps: "5", sets: "3", rpe: "10", rest: "60-90s"),
//        Exercise(exercise: "Med Ball Half Kneeling Wood Chop Throw", reps: "10 ES", sets: "3", rpe: "8", rest: "30s"),
//            ],
//            cooldowns: [
//                Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 2",
//            warmups: [
//                Exercise(exercise: "SMR Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Quadruped T-Spine Rotation", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Band Pull Aparts", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Shoulder Press", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "TRX Row", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Standing Med Ball Chest Pass", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Chin-Ups", reps: "10", sets: "3", rpe: "8", rest: "60-120s"),
//        Exercise(exercise: "Dumbbell Bench Press", reps: "10", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Dumbbell Chest Supported Row", reps: "10", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Cable Bicep Curl", reps: "10", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Cable Tricep Pushdown", reps: "10", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Cable Lateral Raise", reps: "10 ES", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Barbell Jerk", reps: "10", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Ab Roll-Out", reps: "10", sets: "3", rpe: "8", rest: "<30s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Wall Shoulder Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Posterior Capsule Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Half Kneeling Lat Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "SMR Angels", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "SMR Swimmers", reps: "10", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 3",
//            warmups: [
////                Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Walking", reps: "35-40 MIN", sets: "1", rpe: "7.5", rest: "0"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 4",
//            warmups: [
//                Exercise(exercise: "SMR Quads", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Leg Swings", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Squat", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Barbell Front Squat", reps: "10", sets: "3", rpe: "8", rest: "60s"),
//        Exercise(exercise: "Dumbbell Reverse Lunge with Knee Raise", reps: "10 EL", sets: "3", rpe: "8", rest: "60-120s"),
//        Exercise(exercise: "Safety Squat Bar Good Morning", reps: "10", sets: "3", rpe: "8", rest: "60s"),
//        Exercise(exercise: "(Assisted) Dumbbell Single Leg Calf Raises", reps: "10 EL", sets: "3", rpe: "8", rest: "60-120s"),
//        Exercise(exercise: "Straight Leg Copenhagen Plank", reps: "30 SEC ES", sets: "3", rpe: "8", rest: "30s"),
//        Exercise(exercise: "Box Deficit Hip Dips", reps: "10 EL", sets: "3", rpe: "8", rest: "30s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Runners Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Downward Dog", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 5",
//            warmups: [
////                Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Barbell Hang Clean", reps: "10", sets: "3", rpe: "8", rest: "60s"),
//        Exercise(exercise: "Lateral Box Hop Over", reps: "10 EL", sets: "3", rpe: "9", rest: "30s"),
//        Exercise(exercise: "Reverse Lunge to Sprinter Step-up", reps: "10 EL", sets: "3", rpe: "9", rest: "30s"),
//        Exercise(exercise: "Single Arm MB Floor Chest Throw", reps: "10 ES", sets: "3", rpe: "9", rest: "30s-60s"),
//        Exercise(exercise: "Single Arm Dumbbell Pendulum Clean", reps: "10 ES", sets: "3", rpe: "8", rest: "60-120s"),
//        Exercise(exercise: "Side Plank Leg Lift (Abduction)", reps: "10 ES", sets: "3", rpe: "8", rest: "30s"),
//        Exercise(exercise: "Star Abs", reps: "10", sets: "3", rpe: "8", rest: "60s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//        ])
//        ]
//
//    // WEEK 11-13 Exercises
//    let week_11_13_exercises = [
//        WorkoutProgram(
//            day: "Day 1",
//            warmups: [
////                Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [        Exercise(exercise: "Seated Box Jump", reps: "5", sets: "3", rpe: "10", rest: "60s"),
//        Exercise(exercise: "Box Jump Single Leg Land", reps: "4 EL", sets: "3", rpe: "10", rest: "60-120s"),
//        Exercise(exercise: "Barbell Sumo Deadlift", reps: "8", sets: "3", rpe: "8", rest: "30s"),
//        Exercise(exercise: "Band Resisted Broad Jumps", reps: "5", sets: "3", rpe: "10", rest: "60-90s"),
//        Exercise(exercise: "Barbell Zombie Squat", reps: "8", sets: "3", rpe: "8", rest: "30s"),
//        Exercise(exercise: "Jump Squats", reps: "5", sets: "3", rpe: "10", rest: "60-90s"),
//        Exercise(exercise: "Med Ball Sit-Up Throw", reps: "8", sets: "3", rpe: "8", rest: "30s"),
//                                  ],
//                                  cooldowns: [
//                                    Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                                    Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                                    Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                                    Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                                    Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                                    Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                                    Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 2",
//            warmups: [
//                Exercise(exercise: "SMR Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Quadruped T-Spine Rotation", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Band Pull Aparts", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Shoulder Press", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "TRX Row", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Standing Med Ball Chest Pass", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Cable Lat Pulldown", reps: "8", sets: "3", rpe: "8", rest: "60-120s"),
//        Exercise(exercise: "Dumbbell Bench Press", reps: "8", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Dumbbell Bent Over Row", reps: "8 ES", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Dumbbell ISO Hammer Curl", reps: "8", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Dumbbell JM Press", reps: "8", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Dumbbell Front Raises", reps: "8", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Dumbbell Seated Shoulder Press", reps: "8", sets: "3", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Dragon Flag", reps: "8", sets: "3", rpe: "8", rest: "<30s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Wall Shoulder Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Posterior Capsule Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Half Kneeling Lat Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "SMR Angels", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "SMR Swimmers", reps: "10", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 3",
//            warmups: [
////                Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Walking", reps: "40-45 MIN", sets: "nan", rpe: "8", rest: "0"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 4",
//            warmups: [
//                Exercise(exercise: "SMR Quads", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Leg Swings", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Squat", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Safety Bar Squat", reps: "8", sets: "3", rpe: "8", rest: "120s-180s"),
//        Exercise(exercise: "Kickstand Dumbbell RDL", reps: "8 EL", sets: "3", rpe: "8", rest: "60-120s"),
//        Exercise(exercise: "Barbell Hip Thrust", reps: "8", sets: "3", rpe: "8", rest: "60s"),
//        Exercise(exercise: "Seated Dumbbell Calf Raises", reps: "8", sets: "3", rpe: "8", rest: "60-120s"),
//        Exercise(exercise: "TRX Cossack Squat", reps: "8 EL", sets: "3", rpe: "8", rest: "30s"),
//        Exercise(exercise: "Dumbbell Curtsy Lunge with Knee Drive", reps: "8 EL", sets: "3", rpe: "8", rest: "120-180s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Runners Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Downward Dog", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 5",
//            warmups: [
////                Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Landmine Thruster", reps: "8", sets: "3", rpe: "8", rest: "60s"),
//        Exercise(exercise: "Two Feet Side Hops", reps: "8", sets: "3", rpe: "10", rest: "30s"),
//        Exercise(exercise: "Lateral Band Resisted Jump Lunges", reps: "8 ES", sets: "3", rpe: "10", rest: "60s"),
//        Exercise(exercise: "American Kettlebell Swing", reps: "8", sets: "3", rpe: "8", rest: "30s-60s"),
//        Exercise(exercise: "Med Ball Rainbow Slam", reps: "8", sets: "3", rpe: "10", rest: "60-120s"),
//        Exercise(exercise: "Windshield Wipers", reps: "8 ES", sets: "3", rpe: "8", rest: "30s"),
//        Exercise(exercise: "Weighted Sit-Up", reps: "8", sets: "3", rpe: "8", rest: "60s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//    ])
//    ]
//
//    // WEEK 14 Exercises
//    let week_14_exercises = [
//        WorkoutProgram(
//            day: "Day 1",
//            warmups: [
////                Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Max Standing Vertical Jump Test", reps: "1", sets: "3-4", rpe: "10", rest: "120-180s"),
//        Exercise(exercise: "Max Standing Broad Jump Test", reps: "1", sets: "3-4", rpe: "10", rest: "120-180s"),
//        Exercise(exercise: "Barbell Deadlift", reps: "5", sets: "3-5", rpe: "10", rest: "120-180s"),
//        Exercise(exercise: "Max Front Plank", reps: "1", sets: "1", rpe: "10", rest: "30s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 2",
//         warmups: [
//            Exercise(exercise: "SMR Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Quadruped T-Spine Rotation", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Band Pull Aparts", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Shoulder Press", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "TRX Row", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Standing Med Ball Chest Pass", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Pull-Ups", reps: "AMRAP", sets: "1", rpe: "10", rest: "120-180s"),
//        Exercise(exercise: "Push-Up", reps: "AMRAP", sets: "1", rpe: "10", rest: "120-180s"),
//        Exercise(exercise: "Dumbbell Single Arm Preacher Curl", reps: "6 ES", sets: "4", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Dumbbell Tate Press", reps: "6", sets: "4", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Dumbbell Upright Row", reps: "6", sets: "4", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Dumbbell Arnold Press", reps: "6", sets: "4", rpe: "8", rest: "<30s"),
//        Exercise(exercise: "Weighted In and Outs", reps: "6", sets: "4", rpe: "8", rest: "<30s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Wall Shoulder Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Posterior Capsule Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Half Kneeling Lat Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "SMR Angels", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "SMR Swimmers", reps: "10", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 3",
//            warmups: [
////                Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Walking", reps: "40-45 MIN", sets: "1", rpe: "8", rest: "0"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 4",
//            warmups: [
//                Exercise(exercise: "SMR Quads", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Leg Swings", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Banded Squat", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//                Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Barbell Back Squat", reps: "5", sets: "3-5", rpe: "10", rest: "120s-180s"),
//        Exercise(exercise: "Barbell Hip Thrust", reps: "5", sets: "3-5", rpe: "10", rest: "120-180s"),
//        Exercise(exercise: "Dumbbell B Stance RDL", reps: "6 EL", sets: "4", rpe: "8", rest: "60-120s"),
//        Exercise(exercise: "Cossack Squat", reps: "6 EL", sets: "4", rpe: "8", rest: "30s"),
//        Exercise(exercise: "Curtsy Lunge Step-Up", reps: "6 EL", sets: "4", rpe: "8", rest: "120-180s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Runners Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Downward Dog", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//        ]),
//        
//        WorkoutProgram(
//            day: "Day 5",
//            warmups: [
////                Exercise(exercise: "SMR Quads & Chest", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Half Kneeling Hip Flexor Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "90:90 Hip Wipers", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Toe Touch to Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Worlds Greatest Stretch", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Glute Bridge", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Bird Dog", reps: "10 ES", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Squat", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Banded Pass Throughs", reps: "10", sets: "1", rpe: "5", rest: "<30s"),
//            Exercise(exercise: "Jump Squats", reps: "10", sets: "1", rpe: "10", rest: "<30s"),
//            ],
//                        workouts: [
//        Exercise(exercise: "Med Ball Jump Slam", reps: "6", sets: "4", rpe: "8", rest: "60-120s"),
//        Exercise(exercise: "Lateral High Knee Pause", reps: "6", sets: "4", rpe: "10", rest: "30s"),
//        Exercise(exercise: "Overhead Plate Jump Lunges", reps: "6 ES", sets: "4", rpe: "10", rest: "60s"),
//        Exercise(exercise: "Landmine Split Jerk", reps: "6 ES", sets: "4", rpe: "8", rest: "30s-60s"),
//        Exercise(exercise: "Landmine Rainbows", reps: "6", sets: "4", rpe: "8", rest: "60-120s"),
//        Exercise(exercise: "Hollow Hold", reps: "30 SEC", sets: "4", rpe: "10", rest: "60s"),
//                        ],
//                        cooldowns: [
//                            Exercise(exercise: "Table or Bench Pigeon Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Couch Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench Tricep Stretch", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Bench 90:90 Chest Opener", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Childs Pose Hand Weave", reps: "1", sets: "1", rpe: "5", rest: "<30s"),
//                            Exercise(exercise: "Seated Neck Stretch", reps: "1 ES", sets: "1", rpe: "5", rest: "<30s")
//        ])
//        ]
//                       return [
//                           WorkoutWeek(weekName: "Baseline Week 1", days: baseline_week1_exercises),
//                           WorkoutWeek(weekName: "Weeks 2-4", days: week_2_4_exercises),
//                           WorkoutWeek(weekName: "Weeks 5-7", days: week_5_7_exercises),
//                           WorkoutWeek(weekName: "Weeks 8-10", days: week_8_10_exercises),
//                           WorkoutWeek(weekName: "Weeks 11-13", days: week_11_13_exercises),
//                           WorkoutWeek(weekName: "Week 14", days: week_14_exercises)
//                       ]
//        }
////// MARK: - ContentView (Home Screen)
////        struct ContentView: View {
////    // Define the weeks array and initialize it with workout weeks
////    let weeks: [WorkoutWeek] = loadWorkoutWeeks()
////
////    var body: some View {
////        NavigationView {
////            ZStack {
////                // Background Image - Fills the entire screen
////                Image("unleashjump 1") // Replace with your image name in Assets.xcassets
////                    .resizable()
////                    .scaledToFill()
////                    .frame(maxWidth: .infinity, maxHeight: .infinity)
////                    .edgesIgnoringSafeArea(.all)
////                
////                // Bottom Section (Button and Background)
////                VStack {
////                    Spacer() // Pushes the button and background to the bottom
////                    
////                    // Custom green background for the button
////                    ZStack {
////                        Color(hex: "c5e668")
////                            .frame(maxWidth: .infinity) // Ensures the background stretches to the full width
////                            .frame(height: 100) // Set the height separately
//////                            .cornerRadius(30, corners: [.topLeft, .topRight]) // Rounded top corners
////                        
////                        // UNLEASH button with logo and text
////                        HStack {
////                            // Optional Logo - Replace with your logo name in Assets.xcassets
////                            Image("7 copy")
////                                .resizable()
////                                .frame(width: 120, height: 30) // Adjust size of logo
////                                .padding(.trailing, 5) // Adds spacing between logo and text
////                            
////                            // Button text
////                            Text("14 WEEK PROGRAM")
////                                .font(.title2)
////                                .fontWeight(.black)
////                                .foregroundColor(.white)
////                        }
////                    }
////                    .padding(.horizontal, 30) // Add padding to prevent text from getting too close to the edges
////                    
////                    // Navigation button for the 14-week program
////                    NavigationLink(destination: WeekSelectionView()) {
////                        Text("START PROGRAM")
////                            .font(.headline)
////                            .fontWeight(.bold)
////                            .foregroundColor(.white)
////                            .padding()
////                            .background(Color.blue) // Button color
////                            .cornerRadius(10)
////                    }
////                    .padding(.bottom, 20) // Spacing below the button
////                }
////            }
////        }
////    }
////}
////
////// MARK: - WeekSelectionView
////struct WeekSelectionView: View {
////    let weeks: [WorkoutWeek] = loadWorkoutWeeks()
////
////    var body: some View {
////        NavigationView {
////            if !weeks.isEmpty {
////                List(weeks) { week in
////                    NavigationLink(destination: DaySelectionView(week: week)) {
////                        Text(week.weekName)
////                            .font(.headline)
////                    }
////                }
////                .navigationTitle("Select a Week")
////            } else {
////                // Provide a fallback view if weeks are empty
////                Text("No workout weeks available")
////                    .navigationTitle("Workout Weeks")
////            }
////        }
////    }
////}
////
////// MARK: - Day Selection View
////struct DaySelectionView: View {
////    let week: WorkoutWeek
////
////    var body: some View {
////        List(week.days, id: \.day) { day in
////            NavigationLink(
////                destination: WorkoutDetailView(day: day)) {  // Pass the `day` to WorkoutDetailView
////                Text(day.day)
////                    .font(.headline)
////            }
////        }
////    }
////}
////
////               // MARK: - Workout Detail View (Exercise List for a Day)
////struct WorkoutDetailView: View {
////    let day: WorkoutProgram
////
////    var body: some View {
////        ScrollView {
////            VStack(alignment: .leading, spacing: 20) {
////                Text(day.day)
////                    .font(.largeTitle)
////                    .bold()
////                    .padding(.top, 20)
////                
////                // Warm-ups section
////                if !day.warmups.isEmpty {
////                    SectionHeader(title: "Warm-ups")
////                    ForEach(day.warmups, id: \.exercise) { warmup in
////                        ExerciseView(workout: warmup)
////                    }
////                }
////
////                // Workouts section
////                if !day.workouts.isEmpty {
////                    SectionHeader(title: "Workouts")
////                    ForEach(day.workouts, id: \.exercise) { workout in
////                        ExerciseView(workout: workout)
////                    }
////                }
////
////                // Cool-downs section
////                if !day.cooldowns.isEmpty {
////                    SectionHeader(title: "Cool-downs")
////                    ForEach(day.cooldowns, id: \.exercise) { cooldown in
////                        ExerciseView(workout: cooldown)
////                    }
////                }
////            }
////            .padding()
////        }
////        .navigationTitle("\(day.day) Details")
////    }
////}
////
////// Section Header View
////struct SectionHeader: View {
////    var title: String
////
////    var body: some View {
////        Text(title)
////            .font(.title2)
////            .bold()
////            .padding(.vertical, 10)
////            .frame(maxWidth: .infinity, alignment: .leading)
////            .background(Color.orange)
////            .foregroundColor(.white)
////    }
////}
////// MARK: - ExerciseView (Logging, Video Player, and Notes)
////struct ExerciseView: View {
////    var workout: Exercise
////    @State private var weightInput: String = ""
////    @State private var notesInput: String = ""
////    @State private var completedSets = [Bool](repeating: false, count: 4) // Example for 4 sets
////    
////    // Dynamically load the video URL from the app bundle
////    var videoURL: URL? {
////        Bundle.main.url(forResource: workout.exercise, withExtension: "mp4")
////    }
////    
////    var body: some View {
////        VStack(alignment: .leading, spacing: 15) {
////            Text(workout.exercise)
////                .font(.title2)
////                .bold()
////                .foregroundColor(.white)
////            
////            Text("Sets: \(workout.sets) | Reps: \(workout.reps) | RPE: \(workout.rpe) | Rest: \(workout.rest) seconds")
////                .font(.subheadline)
////                .foregroundColor(.white)
////            
////            // Video button for each exercise
////            if let videoURL = videoURL {
////                VideoPlayerButton(videoURL: videoURL)
////            } else {
////                Text("Video not available")
////                    .foregroundColor(.red)
////                    .font(.subheadline)
////            }
////            
////            // Set logging section
////            if let sets = Int(workout.sets) {
////                ForEach(0..<sets, id: \.self) { setIndex in
////                    HStack {
////                        Text("Set \(setIndex + 1)")
////                        TextField("Enter weight", text: $weightInput)
////                            .textFieldStyle(RoundedBorderTextFieldStyle())
//////                            .keyboardType(.numberPad)
////                            .foregroundColor(Color(hex: "e25987")) // Pink color for text input
////                            .frame(width: 100)
////                        
////                        Button(action: {
////                            logSet(setIndex: setIndex)
////                        }) {
////                            Text(completedSets[setIndex] ? "Logged" : "Log Set")
////                                .foregroundColor(.white)
////                                .padding(.horizontal)
////                                .padding(.vertical, 5)
////                                .background(completedSets[setIndex] ? Color.green : Color(hex: "c5e668")) // Green color for log button
////                                .cornerRadius(10)
////                        }
////                    }
////                }
////            } else {
////                Text("Invalid sets value")
////            }
////            
////            // Notes section
////            VStack(alignment: .leading) {
////                Text("Notes:")
////                    .font(.headline)
////                    .foregroundColor(.white)
////                TextField("Write notes here", text: $notesInput)
////                    .textFieldStyle(RoundedBorderTextFieldStyle())
////                    .frame(height: 100)
////                    .padding(.top, 5)
////            }
////            
////            // Check button to mark all sets as completed
////            if completedSets.allSatisfy({ $0 }) {
////                Text("✅ All sets completed!")
////                    .foregroundColor(.green)
////                    .font(.headline)
////            }
////        }
////        .padding()
////        .background(Color(hex: "ffaf00")) // Orange background for exercise blocks
////        .cornerRadius(10)
////        .foregroundColor(.white)
////        .padding(.bottom, 10)
////    }
////    
////    // Function to log the set
////    func logSet(setIndex: Int) {
////        if !weightInput.isEmpty {
////            completedSets[setIndex] = true
////        }
////    }
////}
////
////// MARK: - Video Player Button
////struct VideoPlayerButton: View {
////    let videoURL: URL
////    
////    var body: some View {
////        NavigationLink(destination: VideoPlayer(player: AVPlayer(url: videoURL))) {
////            HStack {
////                Image(systemName: "play.circle.fill")
////                    .resizable()
////                    .frame(width: 40, height: 40)
////                    .foregroundColor(Color(hex: "e25987")) // Pink color for video button
////                Text("Watch Video")
////                    .font(.title2)
////            }
////        }
////    }
////}
////
////// MARK: - Hex Color Extension
////extension Color {
////    init(hex: String) {
////        let scanner = Scanner(string: hex)
////        _ = scanner.scanString("#") // Allows optional use of # in hex strings
////        
////        var rgb: UInt64 = 0
////        scanner.scanHexInt64(&rgb)
////        
////        let r = Double((rgb >> 16) & 0xFF) / 255.0
////        let g = Double((rgb >> 8) & 0xFF) / 255.0
////        let b = Double(rgb & 0xFF) / 255.0
////        
////        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1.0)
////    }
////}
////
////// MARK: - Extension for Rounded Corners (optional, for better design)
//////extension View {
//////    func cornerRadius(_ radius: CGFloat) -> some View {
//////        clipShape(RoundedCorner())
//////    }
//////}
////
//////struct RoundedCorner: Shape {
//////    var radius: CGFloat = .infinity
////////    var corners: UIRectCorner = .allCorners
//////
//////    func path(in rect: CGRect) -> Path {
////////        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//////        return Path(path.cgPath)
//////    }
//////}
////
////// MARK: - Preview
////struct ContentView_Previews: PreviewProvider {
////    static var previews: some View {
////        ContentView()
////    }
////}
