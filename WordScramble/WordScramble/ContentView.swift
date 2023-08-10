//
//  ContentView.swift
//  WordScramble
//
//  Created by Julian Saxl on 2023-07-07.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                 TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section("Score") {
                    Text("\(score)")
                        .font(.largeTitle)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text("\(word)")
                        }.accessibilityElement(children: .ignore)
                            .accessibilityLabel("\(word), \(word.count) points")
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit {
                addNewWord()
            }
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }.toolbar {
                Button("Restart") {
                    restart()
                }.buttonStyle(.borderedProminent)
            }
        }
    }
    
    func startGame() {
        if let fileUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let fileContent = try? String(contentsOf: fileUrl) {
                let words = fileContent.components(separatedBy: "\n")
                rootWord = words.randomElement() ?? "silkworm"
                return
            }
        }
       fatalError("Could not load start.txt from bundle.")
    }

    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "Word already used", message: "Be more original.")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "That word can not be formed out of the letters of \(rootWord)!")
            return
        }
        guard isRealWord(word: answer) else {
            wordError(title: "Word doesn't exist", message: "That is not an English word.")
            return
        }
        guard isTooShort(word: answer) else {
            wordError(title: "Word is too short", message: "Your word has to be at least three letters long.")
            return
        }
        guard !isRootWord(word: answer) else {
            wordError(title: "Word is the starting word", message: "While technically correct, please choose a word that is not the starting word.")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            score += answer.count
        }
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isRealWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isTooShort(word: String) -> Bool {
        return word.count >= 3
    }
    
    func isRootWord(word: String) -> Bool {
        return word == rootWord
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func restart() {
        usedWords = []
        newWord = ""
        score = 0
        startGame()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
