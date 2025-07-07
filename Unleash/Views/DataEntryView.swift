////
////  DataEntryView.swift
////  Unleash
////
////  Created by Sam Toll on 2/6/25.
////
///
import SwiftUI

enum EntryMode {
    case reps
    case time
}

struct DataEntryView: View {
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    @Environment(\.presentationMode) var presentationMode
    
    @State var weight: String
    @State var selectedReps: Int
    @State var selectedUnit: String = "lbs"
    @State var entryMode: EntryMode = .reps
    @State var enteredTime: String = ""
    
    let setIndex: Int
    let onSave: (Int, Double, Int?, String, Int?) -> Void
    
    let availableReps = Array(1...30)  // Reps from 4 to 13

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                toggleInputModeView()
                ZStack {
                    if entryMode == .reps {
                        selectRepsView()
                    } else {
                        timeEntryView()
                    }
                }
                .frame(height: 100)
                weightEntryView()
                bodyWeightButton()
                trackButton()
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(AppConfig.Styles.Colors.main_light_blue))
                    .shadow(radius: 5)
            )
        }
        .frame(maxWidth: .infinity)
        .padding(30)
    }
    
    /// **Mode Picker**
   private func entryModePicker() -> some View {
       Picker("Entry Mode", selection: $entryMode) {
           Text("Reps").tag(EntryMode.reps)
           Text("Time (sec)").tag(EntryMode.time)
       }
       .pickerStyle(SegmentedPickerStyle())
       .padding(.bottom, 10)
   }
    
    /// Reps vs Time Toggle Picker
    private func toggleInputModeView() -> some View {
        HStack(spacing: 0) {
            modeButton(title: "Reps", isSelected: entryMode == .reps) {
                entryMode = .reps
            }
            modeButton(title: "Time", isSelected: entryMode == .time) {
                entryMode = .time
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(AppConfig.Styles.Colors.main_dark_blue), lineWidth: 2)
        )
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
        )
        .padding(.top, 5)
        .padding(.horizontal, 5)
    }


    private func modeButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.custom("Nexa-Heavy", size: 16))
                .foregroundColor(isSelected ? .white : Color(AppConfig.Styles.Colors.main_dark_blue))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(isSelected ? Color(AppConfig.Styles.Colors.main_dark_blue) : Color.clear)
                )
        }
    }


    /// **Reps Selection View**
    private func selectRepsView() -> some View {
        VStack {
            Text("select your reps")
                .font(.custom("Nexa-Heavy", size: 18))
                .foregroundColor(.black)
                .padding(.top, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(availableReps, id: \.self) { rep in
                        VStack {
                            Text("\(rep)")
                                .font(.custom("Nexa-Heavy", size: 20))
                                .foregroundColor(selectedReps == rep ? Color(AppConfig.Styles.Colors.main_bright_pink) : Color(AppConfig.Styles.Colors.main_dark_blue))
                                .onTapGesture {
                                    selectedReps = rep
                                }
                            if selectedReps == rep {
                                Spacer()
                                Rectangle()
                                    .background(Color(AppConfig.Styles.Colors.main_bright_pink))
                                    .foregroundStyle(Color(AppConfig.Styles.Colors.main_bright_pink))
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
                    .background(Color(AppConfig.Styles.Colors.main_dark_blue))
                    .foregroundStyle(Color(AppConfig.Styles.Colors.main_dark_blue))
                    .frame(height: 5)
                    .offset(y: -10)
            }
        }
        .padding(.vertical, 20)
    }
    
    /// **Time Entry View**
    private func timeEntryView() -> some View {
        VStack {
            Text("enter time in seconds")
                .font(.custom("Nexa-Heavy", size: 16))
                .foregroundColor(.black)

            TextField("Time", text: $enteredTime)
                .keyboardType(.numberPad)
                .font(.custom("Nexa-Heavy", size: 20))
                .frame(width: 100, height: 25)
                .multilineTextAlignment(.center)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(AppConfig.Styles.Colors.main_neon_green), lineWidth: 3)
                )
                .onChange(of: enteredTime) { newValue in
                    enteredTime = newValue.filter { "0123456789".contains($0) }
                }
        }
        .padding(.bottom, 10)
    }

    /// **Weight Entry and Unit Selector**
    private func weightEntryView() -> some View {
        VStack {
            Text("enter weight used")
                .font(.custom("Nexa-Heavy", size: 16))
                .foregroundColor(.black)
            
            HStack {
                TextField("Weight", text: $weight)
                    .keyboardType(.decimalPad)
                    .font(.custom("Nexa-Heavy", size: 20))
                    .frame(width: 100, height: 25)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(AppConfig.Styles.Colors.main_neon_green), lineWidth: 3)
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
                .fill(selectedUnit == unit ? Color(AppConfig.Styles.Colors.main_bright_pink) : Color.clear)
                .frame(width: 15, height: 15)
                .overlay(Circle().stroke(Color(AppConfig.Styles.Colors.main_bright_pink), lineWidth: 2))
                .onTapGesture {
                    selectedUnit = unit
                }
            Text(title)
                .font(.custom("Nexa-Heavy", size: 18))
                .foregroundColor(.black)
        }
    }

    /// **Bodyweight Button**
    private func bodyWeightButton() -> some View {
        Button {
            weight = "0"
        } label: {
            Text("I USED BODY WEIGHT")
                .font(.custom("Nexa-Heavy", size: 14))
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 30)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(AppConfig.Styles.Colors.main_nude).opacity(0.8))
                )
        }
    }

    /// **Save Button**
    private func trackButton() -> some View {
        Button {
            guard let weightValue = Double(weight) else { return }
            let timeValue = entryMode == .time ? Int(enteredTime) : nil
            let repsValue = entryMode == .reps ? selectedReps : nil
            onSave(setIndex, weightValue, repsValue, selectedUnit, timeValue)
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("TRACK")
                .font(.custom("Nexa-Heavy", size: 20))
                .foregroundColor(.white)
                .padding()
                .frame(width: 150, height: 30)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(AppConfig.Styles.Colors.main_neon_green))
                )
        }
        .padding(.bottom, 20)
    }
}
