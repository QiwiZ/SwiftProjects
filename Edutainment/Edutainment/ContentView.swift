//
//  ContentView.swift
//  Edutainment
//
//  Created by Julian Saxl on 2023-07-10.
//

import SwiftUI

//TODO create custom View for questions and present them all at once in a list. Questions contain their own answer

//struct SettingsView: View {
//    var startGame: () -> Void
//    var multiplicationTable: Binding<Int>
//    @State var amountOfQuestions = 5
//    @State private var multTableButtonOpacity = 1.0
//    @State private var numberOfQuestionsButtonOpacity = 1.0
//
//    var body: some View {
//
//    }
//}
//
//struct GameView: View {
//    var generateQuestion: () -> Void
//    var restart: () -> Void
//    var amountOfQuestions: Int
//
//    @State private var playerScore = 0
//    @State private var userAnswer = 0
//    @State private var correctAnswer = 0
//    @FocusState private var answerFieldFocused: Bool
//    @State private var currentQuestion = ""
//    @State private var currentRound = 1
//    @State private var showingScore = false
//
//    var body: some View {
//
//    }
//}

struct ContentView: View {
    @State var amountOfQuestions = 5
    @State private var multTableButtonOpacity = 1.0
    @State private var numberOfQuestionsButtonOpacity = 1.0
    @State var multiplicationTable = 2
    @State private var inSettings = true
    @State private var playerScore = 0
    @State private var userAnswer = 0
    @State private var correctAnswer = 0
    @FocusState private var answerFieldFocused: Bool
    @State private var currentQuestion = ""
    @State private var currentRound = 1
    @State private var showingScore = false
    private let layout = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        VStack {
            if inSettings{
                NavigationView {
                    VStack {
                        Spacer()
                        Section("Multiplication table") {
                            LazyVGrid(columns: layout) {
                                ForEach(2..<15) { number in
                                    Button("\(number)") {
                                        withAnimation {
                                            multTableButtonOpacity = 0.4
                                        }
                                        multiplicationTable = number
                                    }.padding(5)
                                        .frame(width: 60, height: 50)
                                        .background(Color(red: 0.05 * Double(number), green: 2 / Double(number), blue: 0.74))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .foregroundColor(.white)
                                        .opacity(number == multiplicationTable ? 1 : multTableButtonOpacity)
                                }
                            }
                        }
                        Section("Number of questions") {
                            HStack {
                                ForEach(1..<5) { number in
                                    Button("\(number*5)") {
                                        withAnimation{
                                            numberOfQuestionsButtonOpacity = 0.4
                                        }
                                        amountOfQuestions = number*5
                                    }.padding(15)
                                        .frame(width: 60, height: 50)
                                        .background(Color(red: 0.08 * Double(number), green: 0.8 / Double(number), blue: 0.74))
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .opacity(number*5 == amountOfQuestions ? 1 : numberOfQuestionsButtonOpacity)
                                }
                            }
                        }
                        Spacer()
                        Button("Start") {
                            startGame()
                        }
                        .padding(50)
                        .frame(width: 200, height: 50)
                        .background(.green)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }.padding()
                        .navigationTitle("Choose your questions")
                }
            }
            else {
                NavigationView {
                    Form {
                        TextField("Answer", value:$userAnswer, format: .number)
                            .keyboardType(.numberPad)
                            .focused($answerFieldFocused)
                    }
                    .navigationTitle(currentQuestion)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                answerFieldFocused = false
                            }
                        }
                    }
                    .onSubmit {
                        if userAnswer == correctAnswer {
                            playerScore += 1
                        }
                        if currentRound == amountOfQuestions {
                            showingScore = true
                        }
                        currentRound += 1
                        userAnswer = 0
                        generateQuestion()
                    }
                }.alert("Game over", isPresented: $showingScore) {
                    Button("Start again") {
                        restart()
                    }
                } message: {
                    Text("Your final score is: \(playerScore)")
                        .font(.largeTitle)
                }
            }
        }
    }
    
    func startGame() {
        generateQuestion()
        inSettings = false
    }
    
    func generateQuestion(){
        let randomFactor = Int.random(in: 1...25)
        correctAnswer = randomFactor * multiplicationTable
        currentQuestion = "What is \(randomFactor) x \(multiplicationTable)"
    }
    
    func restart() {
        inSettings = true
        playerScore = 0
        multiplicationTable = 2
        multTableButtonOpacity = 1
        numberOfQuestionsButtonOpacity = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
