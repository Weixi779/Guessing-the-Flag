//
//  ContentView.swift
//  Guessing the Flag
//
//  Created by 孙世伟 on 2020/5/18.
//  Copyright © 2020 me.Weixi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var correct = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack(spacing:30){
                VStack(spacing: 10){
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3){ number in
                    Button(action: {
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                        .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black,lineWidth: 1))
                            .shadow(color: .black, radius: 2, x: 5, y: 5)
                    }
                }
                Spacer()
            }
            .alert(isPresented: $showingScore){
                Alert(title: Text(scoreTitle),message: Text("\(correct)"),dismissButton:  .default(Text("Continue")){
                        self.askQuestion()
                    })
            }
        }
        
        
    }
     func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number:Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 10
            correct = "\n Your score is \(score)"
        }else{
            scoreTitle = "Wrong"
            correct = "\n You selection answer is \(countries[number])"
        }
        showingScore = true
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
