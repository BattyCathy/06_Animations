//
//  Notes Day 2.swift
//  06_Animations
//
//  Created by Austin Roach on 2/3/21.
//

import Foundation

//MARK: Day 33

//MARK: Project 6, part 2


//Today we're going to be getting into more advanced animations, and it's where you'll start to get a deeper understanding of how animations work and how you can customize them to a remarkable degree.

//There's a famous industrial designer from Germany called Dieter Rams. you might now have heard of him, but you've certainly seen his work - his designs have hugely inspired Apple's own designs for years, from the iPod to the iMac and the Mac Pro. he once said, "good design is making something intelligible and memorable; great design is making something memorable and meaningful."

//SwiftUI's powerful animations can't just look good, there's always some room for whimsy in app development. But when important changes are happening, it's important we try to help the user understand what's changing and why. In SiwftUI, this is largely the job of transitions, which you'll meet today;

//Today you have four topics to work through, in which you'll learn about multiple animations, gesture animations, transitions, and more.


//MARK: 1. Controlling the Animation Stack

//At this pont, I want to put together two things that you already understand individually, but together might hurt your head a little.

//Previously we looked at how the order of modifiers matters. So, if we wrote code like this:

/*
 Button("Tap Me") {
    // do nothing
 }
 .background(Color.blue)
 .frame(width: 200, height: 200)
 .foregroundColor(.white)
 */

//The result would look different from code like this:

/*
 Button("Tap Me") {
    // do nothing
 }
 .frame(width:200, height: 200)
 .background(Color.blue)
 .foregroundColor(.white)
 */

//That is because if we color the backgroud before adjusting the frame, only the onriginal space is colored rather than the expanded space. If you recall, the underlying reason for this is the way SwiftUI wraps views with modifiers, allowing us to apply the same modifier multiple times - we repeated background() and padding() several times to create a striped border effect.

//That's concept one: modifier order matters, because SwiftUI wraps views with modifiers in the order they are applied.

//Cencept two is that we can apply an animation() modifier to a view in order to have it implicitly animate changes.

//To demonstrate this, we could modify our button code so that it shows different colors depending on some state. First, we define the state:

//@State private var enabled = false

//We can toggle that between true and false inside our button's action:

//Self.enabled.toggle()

//Then we can use a conditional value inside the background() modifier so the button is either bluue or red:

//.background(enable ? Color.blue : Color.red)

//Finally, we add the animation() modifier to the button to make those changes animate:

//.animation(.default)

//If you run the code you'll see that tapping the button animates its color between blue and red.

//So: modifier order matters and we can attach one modifier several times to a view, and we cacn ause implicit animations to occur with the animation() modifier. All clear so far?

//Right. Brace yourself, becasue this might hurt.

//You can attach the animation() modifier several times, and the order in which you use it matters.

//To demostrate this, I'd like you to add this modifier to your button, after all the other modifiers:

//.clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))

//That will cause the button to move between a square and rounded rectangle depending on the state of the enabled Boolean.

//When you run the program, you'll see that tapping th button causes it to animate between red and blue, but jump btween square and rounded rectangle - that part doesn't animate.

//Hopefully, you can see where we're going next: I'd like you to move the clipShape() modifier before the animation, like this:

/*
 .frame(width: 200, height: 200)
 .background(enabled ? Color.blue : Color.red)
 .foregroundColor(.white)
 .clipShape(RoundedRectangle(conrnerRadius: enabled ? 60 : 0))
 .animation(.default)
 */

//And now when you run the code both the background color and clip shape animate.

//So, the order in which we apply animations matters: only changes that occur before the animation() modifier get animated.

//Now, for the fun part: if we apply multiple animation() modifier, each one controls everything before it up to the next animation. This allows us to animate state changes in all sorts of different ways rather than uniformly for all properties.

//For example, we could make the color change happen with the default animation, but use an interpolating spring for the clip shape:

/*
 Button("Tap Me") {
    slef.enabled.toggle()
 }
 .frame(width: 200, height: 200)
 .background(enabled ? Color.blue : Color.red)
 .animation(.default)
 .foregroundColor(.white)
 .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
 .animation(.interpolatingSpring(stiffness: 10, damping: 1))
 */

//That kind of control wouldn't be possible without multiple animation() modifiers - if you tried to move background() after the animation you'd find that it would just undo the work of clipShape()

//MARK: 2. Animating Gestures

//MARK: 3. Showing and Hiding Views with Transitions

//MARK: 4. Building Custom Transitions Using ViewModifier
