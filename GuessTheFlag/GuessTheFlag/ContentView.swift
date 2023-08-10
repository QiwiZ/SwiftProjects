//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Julian Saxl on 2023-06-27.
//

import SwiftUI

struct FlagImage: View {
    var countryName: String
    
    var body: some View {
        Image(countryName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    private let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var alertMessage = ""
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var playerScore = 0
    @State private var round = 0
    @State private var isFinalRound = false
    @State private var animationAmount = 1.0
    @State private var opacityAmount  = 1.0
    @State private var tappedFlag = 5
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400 )
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack{
                        Text("Tap the correct flag")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(countryName: countries[number])
                                .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                        }
                        .rotation3DEffect(.degrees(number == tappedFlag ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(number == tappedFlag ? 1 : opacityAmount)
                        .alert(scoreTitle, isPresented: $showingScore) {
                            Button("Continue") {
                                askQuestion()
                            }
                        } message: {
                            Text(alertMessage)
                        }
                    }
                }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score is \(playerScore)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
            }.padding()
        }
        .alert("This is the end", isPresented: $isFinalRound) {
            Button("Restart") {
                restart()
            }
        } message: {
            Text("Your final score is \(playerScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        round += 1
        tappedFlag = number
        withAnimation {
            animationAmount += 360
            opacityAmount = 0.25
        }
        if number == correctAnswer {
            scoreTitle = "Correct"
            playerScore += 1
            alertMessage = "That's right! This is the flag of \(countries[number])"
        } else {
            scoreTitle = "Wrong"
            alertMessage = "That's wrong! This is the flag of \(countries[number])"
        }
        showingScore = true
        if round == 8 {
            isFinalRound = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAmount = 1
    }
    
    func restart() {
        round = 0
        playerScore = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
