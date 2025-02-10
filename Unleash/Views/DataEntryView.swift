////
////  DataEntryView.swift
////  Unleash
////
////  Created by Sam Toll on 2/6/25.
////
///
import SwiftUI

struct DataEntryView: View {
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var weight: String = ""
    @State private var selectedReps: Int = 8  // Default reps
    @State private var selectedUnit: String = "lb"
    
    let setIndex: Int
    let onSave: (Int, Double, Int, String) -> Void
    
    let availableReps = Array(1...30)  // Reps from 4 to 13

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                selectRepsView()
                weightEntryView()
                bodyWeightButton()
                trackButton()
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(AppConfig.main_neon_green))
                    .shadow(radius: 5)
            )
        }
        .frame(maxWidth: .infinity)
        .padding(30)
    }

    /// **Reps Selection View**
    private func selectRepsView() -> some View {
        VStack {
            Text("select your reps")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(availableReps, id: \.self) { rep in
                        VStack {
                            Text("\(rep)")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(selectedReps == rep ? Color(AppConfig.main_bright_pink) : .white)
                                .onTapGesture {
                                    selectedReps = rep
                                }
                            if selectedReps == rep {
                                Spacer()
                                Rectangle()
                                    .background(Color(AppConfig.main_bright_pink))
                                    .foregroundStyle(Color(AppConfig.main_bright_pink))
                                    .frame(height: 5)
                                    .offset(y: -3.5)
                            }
                            if selectedReps != rep {
                                Spacer()
                            }
                        }
                        .frame(height: 30)
                    }
                }
                .padding(.horizontal, 20)
            }
            .frame(height: 50)
            .background(alignment: .bottom) {
                Rectangle()
                    .background(.white)
                    .foregroundStyle(.white)
                    .frame(height: 5)
                    .offset(y: -10)
            }
        }
        .padding(.vertical, 20)
    }

    /// **Weight Entry and Unit Selector**
    private func weightEntryView() -> some View {
        VStack {
            Text("enter weight used")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
            
            HStack {
                TextField("Weight", text: $weight)
                    .keyboardType(.decimalPad)
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 100, height: 30)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(AppConfig.main_nude), lineWidth: 3)
                    )
                    .onChange(of: weight) { newValue in
                        weight = newValue.filter { "0123456789.".contains($0) }
                    }

                unitSelector()
            }
        }
    }

    /// **LBS / KGS Unit Selector**
    private func unitSelector() -> some View {
        HStack {
            unitButton(title: "LBS", unit: "lb")
                .padding(.trailing, 5)
            unitButton(title: "KGS", unit: "kg")
        }
        .padding(.leading, 10)
    }

    private func unitButton(title: String, unit: String) -> some View {
        HStack {
            Circle()
                .fill(selectedUnit == unit ? Color(AppConfig.main_bright_pink) : Color.clear)
                .frame(width: 15, height: 15)
                .overlay(Circle().stroke(Color(AppConfig.main_bright_pink), lineWidth: 2))
                .onTapGesture {
                    selectedUnit = unit
                }
            Text(title)
                .foregroundColor(.white)
        }
    }

    /// **Bodyweight Button**
    private func bodyWeightButton() -> some View {
        Button {
            weight = "0"
        } label: {
            Text("I USED BODY WEIGHT")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 30)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(AppConfig.main_nude).opacity(0.8))
                )
        }
    }

    /// **Save Button**
    private func trackButton() -> some View {
        Button {
            guard let weightValue = Double(weight) else { return }
            onSave(setIndex, weightValue, selectedReps, selectedUnit)
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("TRACK")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .padding()
                .frame(width: 150, height: 30)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(AppConfig.main_orange))
                )
        }
        .padding(.bottom, 20)
    }
}


//
//import SwiftUI
//
//struct DataEntryView: View {
//    @EnvironmentObject var appDataStore: AppDataStorage
//    @EnvironmentObject var firebaseManager: FirebaseManager
//    @Environment(\.presentationMode) var presentationMode
//    
//    @State private var weight: String = ""
//    @State private var reps: String = ""
//    @State private var selectedUnit: String = "lb"
//    
//    let setIndex: Int
//    let onSave: (Int, Double, Int, String) -> Void
//    
//    let formatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        return formatter
//    }()
//    
//    var body: some View {
//        VStack {
//            Text("Log Set \(setIndex + 1)")
//                .font(.headline)
//                .padding()
//            
//            TextField("Weight", text: $weight)
//                .keyboardType(.decimalPad)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//                .onChange(of: weight) { newValue in
//                    // Ensure valid decimal format
//                    weight = newValue.filter { "0123456789.".contains($0) }
//                }
//            
//            TextField("Reps", text: $reps)
//                .keyboardType(.numberPad)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//                .onChange(of: reps) { newValue in
//                    // Ensure only digits are entered
//                    reps = newValue.filter { "0123456789".contains($0) }
//                }
//            
//            Picker("Unit", selection: $selectedUnit) {
//                Text("lb").tag("lb")
//                Text("kg").tag("kg")
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .padding()
//            
//            Button("Save") {
//                guard let weightValue = Double(weight), weightValue > 0,
//                      let repsValue = Int(reps), repsValue > 0 else {
//                    return  // Prevent invalid entries
//                }
//                
//                // Pass the validated values back to the parent view
//                onSave(setIndex, weightValue, repsValue, selectedUnit)
//                
//                // Dismiss keyboard and close view
//                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                presentationMode.wrappedValue.dismiss()
//            }
//            .buttonStyle(.borderedProminent)
//            .disabled(weight.isEmpty || reps.isEmpty) // Disable button if inputs are empty
//            .padding()
//        }
//        .padding()
//    }
//}
