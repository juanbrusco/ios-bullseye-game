//
//  ContentView.swift
//  Bulsseye
//
//  Created by Juan Brusco on 17/02/2020.
//  Copyright © 2020 Juan Brusco. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // @State indicator: refresh the body when value changes
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1

    // Object ViewModifier, takes a view and changes it
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.red)
            .modifier(ShadowStyle())
            .font(Font.custom("Arial", size: 18))
        }
    }
    
    // Object ViewModifier, takes a view and changes it
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    var body: some View {
        // Vertical stack
        VStack {
            Spacer()

            // Target row
            HStack {
                Text("Put the bullseye as close as you can do:")
                    .fontWeight(.light)
                    .foregroundColor(Color.red)
                    .shadow(color: Color.black, radius: 5, x: 2, y: 2)
                    .font(Font.custom("Arial", size: 28))
                Text("\(self.target)")
            }
            Spacer()

            // Slider row
            HStack {
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100).accentColor(Color.yellow)
                Text("100")
            }
            Spacer()

            // Button row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
            }
            .modifier(ShadowStyle())
            .alert(isPresented: $alertIsVisible){
                ()-> Alert in
                return Alert(title: Text("Hello"), message: Text("Slider value is \(self.sliderValueRounded()). \n" + "You scored \(self.pointsForCurrentRound())"), dismissButton: .default(Text("OK")){
                        self.score = self.score + self.pointsForCurrentRound()
                        self.target = Int.random(in: 1...100)
                        self.round = self.round + 1
                    })
            }
            Spacer()
            
            // Score row
            HStack {
                Button(action: {
                    self.resetGame()
                }) {
                    Text("Start over")
                }
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(self.score)")
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(self.round)")
                Spacer()
                NavigationLink(destination: AboutView()){
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
        }
        .background(Image("escudo"), alignment: .bottom)
        .navigationBarTitle("Bullseye")
    }
    
    func sliderValueRounded() -> Int {
        return Int(self.sliderValue.rounded())
    }
    
    func pointsForCurrentRound() -> Int {
        let difference: Int=abs(self.target - self.sliderValueRounded())
        var awardedPoints: Int=100-difference
        if difference == 0 {
            awardedPoints = awardedPoints + 100
        }
        return awardedPoints
    }
    
    func resetGame() {
        self.score = 0
        self.round = 1
        self.sliderValue = 50.0
        self.target = Int.random(in: 1...100)
    }
}

// Tell SwiftUI what to present over here as the preview.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Values for Landscape mode of an iPhone XR (points).
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
