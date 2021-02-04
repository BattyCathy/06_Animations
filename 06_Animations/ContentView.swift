//
//  ContentView.swift
//  06_Animations
//
//  Created by Austin Roach on 2/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Text("Hello, world!")
            .padding()
        
        Button("Tap Me") {
            self.animationAmount += 1
        }
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect()
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: false)
                )
        )
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(
            Animation.easeInOut(duration: 1)
                .repeatForever(autoreverses: true)
        )
        .blur(radius: (animationAmount - 1) * 3)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
