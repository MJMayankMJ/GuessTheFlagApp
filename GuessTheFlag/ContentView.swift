//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mayank Jangid on 7/31/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
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
                            fladTapped(number)
                        } label : {
                            Image(countries[number])
                                .clipShape(.rect(cornerRadius: 25))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical ,20)
                .background(.opacity(0.15))
                .clipShape(.rect(cornerRadius: 25))
                .shadow(color: .black.opacity(0.01), radius: 25)
                Spacer()
                Text("Score: ???")
                    .font(.title.bold())
                    .foregroundStyle(Color(red: 0.89, green: 0.89, blue: 0.71))
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
             Text("Your Score is ???")
            // to do
        }
    }
    func fladTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "False"
        }
        showingScore = true
    }
    func askQuestion () {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
