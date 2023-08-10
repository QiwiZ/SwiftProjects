//
//  ContentView.swift
//  RockPaperLose
//
//  Created by Julian Saxl on 2023-07-01.
//

import SwiftUI


struct ContentView: View {
    private let choices = ["Rock", "Paper", "Scissors"]
    @State private var opponentsChoice = Int.random(in: 0...2)
    @State private var playerScore = 0
    @State private var shouldWin = Bool.random()
    @State private var round = 0
    @State private var finalRound = false
    
    var body: some View {
        VStack {
            Text("\(shouldWin ? "Win" : "Lose") against \(choices[opponentsChoice])")
            VStack(spacing: 15) {
                ForEach(0..<3) { number in
                    Button {
                        selectAnswer(number)
                    } label: {
                        Text("\(choices[number])")
                            .foregroundColor(.blue)
                            .font(.system(size: 50))
                    }
                    .padding(5)
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }.alert("Game over", isPresented: $finalRound) {
                Button("Restart") {
                    restart()
                }
            } message: {
                Text("Your final score is \(playerScore)")
            }
        }
    }
    
    func selectAnswer(_ number: Int) {
        round += 1
        if shouldWin && (
            (opponentsChoice == 0 && number == 1) ||
            (opponentsChoice == 1 && number == 2) ||
            (opponentsChoice == 2 && number == 0)
        )
        {
            playerScore += 1
        } else if !shouldWin && (
            (opponentsChoice == 0 && number == 2) ||
            (opponentsChoice == 1 && number == 0) ||
            (opponentsChoice == 2 && number == 1)
        ) {
            playerScore += 1
        }
        if round == 10 {
            finalRound = true
        } else {
            randomizeTask()
        }
    }
    
    func restart() {
        randomizeTask()
        finalRound = false
        round = 0
        playerScore = 0
    }
    
    func randomizeTask() {
        opponentsChoice = Int.random(in: 0...2)
        shouldWin.toggle()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
