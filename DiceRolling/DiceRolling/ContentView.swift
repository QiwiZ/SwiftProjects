//
//  ContentView.swift
//  DiceRolling
//
//  Created by Julian Saxl on 2023-09-05.
//
import CoreHaptics
import SwiftUI

struct ContentView: View {
    @State private var totalResult = 0
    @State private var amountOfDice = 1
    @State private var typeOfDice = 6
    @State private var results = [Int]()
    @State private var engine: CHHapticEngine?
    
    let diceTypes = [4,6,8,10,12,20,100]
    
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    Stepper("Amount of dice: \(amountOfDice)", value: $amountOfDice, in: 1...5)
                    Picker("Type of dice", selection: $typeOfDice) {
                        ForEach(diceTypes, id: \.self) { type in
                            Text(String(type))
                        }
                    }
                }
                
                Spacer()
                
                if totalResult != 0 {
                    Text(String(totalResult))
                        .font(.largeTitle)
                        .frame(width: 100, height: 100)
                        .border(.red)
                }
                Spacer()
                
                Button("Roll the dice") {
                    rollDice()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            .padding()
            .toolbar {
                NavigationLink {
                    ResultHistoryView(results: results)
                } label: {
                    Text("History")
                }
            }
            .onAppear {
                prepareHaptics()
            }
        }
    }
    
    func rollDice() {
        totalResult = 0
        for _ in 0..<amountOfDice {
            totalResult += Int.random(in: 1...typeOfDice)
        }
        results.insert(totalResult, at: 0)
        rollFeedback()
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptics engine could not be started: \(error.localizedDescription)")
        }
    }
    
    func rollFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
