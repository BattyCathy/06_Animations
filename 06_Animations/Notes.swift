//
//  Notes.swift
//  06_Animations
//
//  Created by Austin Roach on 2/3/21.
//

import Foundation

//MARK: DAY 32

//MARK: Project 6, Part 1

//When Steve Jobs introduced Aqua, the visual theme that has powered macOS ever since Mac OS X launched in 2001, he said, "we made buttons on he screen look so good you'll want to lick them." I don't know if you were using Macs way back then, but over the years Aqua has given us glass-like buttons, pin stripes, brushed metal and so much more, and even today the "genie" window minimize looks amazing.

//When we make apps with great visual appeal, users notice. Sure, it won't affect the core functionality of the app, and it's easy to go overboard with design and cause that core to get a little lost, but when you do it right a beautiful user interface brings up a little extra deligth and can help set your app apart from others.

//Animations are one of the fundamental ways we can bring our apps to life, and you'll be pleased to know SwiftUI gives us a range of tools for using them. Today we'll be looking at easier animations, but tomrrow we'll progress onto more difficult stuff - it's a good idea to be aware of both, so you can tackle whatever problems come up in the future.

//Today you have five topics to work through, in which you'll learn about implicit animations, explicit animations, binding animations, and more.

//MARK: 1. Animation Introduction

//We're back to another technique project, and this time we're going to be looking at something fast, beautiful, and really under-valued: animations.

//Animations are there for a few reasons, of which one definitely is to make our user interfaces look better. However, they are also there to help users understand what's going on with our program: when one window disappears and another slides in, it's clear to the user where the other window has gone to, which means it's also clear where they can look to get it back.

//In this technique project we're going to look at a range of animations and transitions with SwiftUI. Some are easy - in fact, you'll be able to get great results almost immediately! - but some require more thinking. All will be useful though, particularly as you work to make sure your apps are attractive and help guide users eyes as best as you can.

//As with the other days it's a good idea to work in an Xcode project so you can see your code in action, so please create a new Single View App project called Animations.

//MARK: 2. Creating Implicit Animations

//In SwiftUI, the simplest type of animation is an implicit one: we tell our views ahead of time "if someone wants to animate you, here's how you should respond", and nothing more. SwiftUI will then take care of making sure changes that do occur follow the animation you requested. In practice this make animation trivial - it literally could not be any easier.

//Let's start with an example. This code shows a simple red button with no action, using 50 points of padding and a circular clip shape:

/*
 Button("Tap Me") {
    //do nothing
 }
 .padding(50)
 .background(Color.red)
 .foreground(Color.white)
 .clipShape(Circle())
 */

//MARK: 3. Customizing Animations in SwiftUI

//MARK: 4. Animating Bindings

//MARK: 5. Creating Explicit Animations
