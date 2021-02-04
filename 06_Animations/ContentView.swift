//
//  ContentView.swift
//  06_Animations
//
//  Created by Austin Roach on 2/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 0.0
    @State private var enabled = false
    
    var body: some View {
        Button("Tap Me") {
            self.enabled.toggle()
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                self.animationAmount += 360
            }
        }
        .padding(50)
      
        .background(enabled ? Color.blue : Color.red)
        .foregroundColor(.white)
        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
        .animation(.default)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
