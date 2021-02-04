//
//  ContentView.swift
//  06_Animations
//
//  Created by Austin Roach on 2/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Tap Me") {
                // do nothing
            }
            
            Rectangle()
                .fill(Color.red)
                .frame(width: 200, height: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
