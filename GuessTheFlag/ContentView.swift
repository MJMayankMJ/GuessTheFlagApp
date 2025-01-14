//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mayank Jangid on 7/31/24.
//

import SwiftUI

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(.rect(cornerRadius: 25))
    }
}


struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var showingResult = false
    @State private var scoreTitle = ""
    @State private var questionNumber = 1
    @State private var score = 0
    @State private var currentCountry = 0
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [
                .cyan, .black
            ], center: .leading, startRadius: 1000, endRadius: 0)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color(red: 0.43, green: 0.67, blue: 0.85))
                Spacer()
                VStack(spacing: 25) {
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(Color(red: 0.01, green: 0.25, blue: 0.55 ))
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(Color(red: 0.43, green: 0.67, blue: 0.85))
                            .font(.largeTitle.weight((.semibold)))
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                            currentCountry = number
                        } label : {
                            Image(countries[number])
                                .modifier(FlagImage())
                        }
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical ,20)
                .background(.opacity(0.15))
                .clipShape(.rect(cornerRadius: 25))
                .shadow(color: .black.opacity(0.01), radius: 25)
                Spacer()
                Text("Score : \(score)")
                    .font(.title.bold())
                    .foregroundStyle(Color(red: 0.89, green: 0.89, blue: 0.71))
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "False" {
                Text("Wrong! That’s the flag of \(countries[currentCountry])")
            } else {
                Text("Correct !!!")
            }
        }
        .alert("Game Completed !", isPresented: $showingResult) {
            Button("Restart", action: askQuestion)
        } message: {
            Text("You scored \(score) points")
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score = score + 3
        } else {
            scoreTitle = "False"
            score = score - 1
        }
        questionNumber = questionNumber + 1
        if questionNumber < 9 {
            showingScore = true
        } else {
            showingResult = true
            questionNumber = 0        }
    }
    func askQuestion () {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        if (questionNumber == 0) {
            score = 0
            //why not just below qestionNumber = 0 in else of flagTapped
            //cz than alert will show score : 0 in final msg result
        }
    }
}

#Preview {
    ContentView()
}
