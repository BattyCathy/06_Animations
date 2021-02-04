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

//What we want is for that button to get bigger every time it's tapped, and we can do that with a new modifier called scaleEffect(). You provide this with a value from 0 up, and it will be drawn at that size - a value of 1.0 is equivalent to 100%, i.e. the button's normal size.

//Because we want to change the scale effect value every time the button is tapped, we need to use an @State propert, but there's a catch here: for historical reasons mostly around interacting with Apple's older APIs, we need to use a specific data type called CGFloat.

//CGFloat is, for all intents and purposes, a Double under a different name, but on older hardware it uses a smaller type of number storage called Float. Back when this choice mattered, CGFloat allowed Apple to not care about which type of hardware we were building for, but nowadays almost everything uses Double so it's just a piece of legacy staring at us with disgust.

//Anyway, all this matters because if we make the property var animationAmount = 1 we get an integer, and if we use var animationAMount = 1.0 then we get a Double, but there is no built in way to get CGFloat automatically - we need to use a type annotations.

//So, please add this property to you view now:

//@State private var animationAmount: CGFloat = 1

//Now we can make the button use that for its scale effect, by adding this modifier:

//.scaleEffect(animationAmount)

//Finally, when the button is tapped we want to increase the animation amount by 1, so use this for the button's action:

//self.animationAmount += 1

//If you run the code you'll see that you can tap the button repeatedly to have it scale up and up. It won't get redrawn at increasingly higher resolutions, so as the button gets bigger you'll see it gets blurry, but that's OK.

//Now, the human eye is highly sensitive to movement - we're extremely good at detecting when things move or change their appearance, which is what makes animation both so important and so pleasing. So, we can ask SwiftUI to create an implicit animation by adding an animation() modifier to the button:

//.animation(.default)

//That asks SwiftUI for a default animation, and immediately you'll see that tapping the button now causes it to scale up with an animation.

//That implicit animation takes effect on all properties of that view change, meaning that if we attach more animating modifiers to the view then they will all change together. For example, we could add a second new modifier to the button, .blur(), which lets us add a Gaussian blur with a special radius:

//.blur(radis: (animationAmount - 1) * 3)

//A radius of (animationAmount - 1) * 3 means the blur radius will start at 0 (no blur), but then move to 3 points, 6 points, 9 points, and beyond as you tap the button.

//If you run the app again, you'll see that it now scales and blurs smoothly.

//The point is that nowhere have we said what each frame of the animation should look like, and we haven't even said when SwiftUI should start and finish the animation. Instead, our animation becomes a function of our state just like the views themselves.


//MARK: 3. Customizing Animations in SwiftUI

//When we attach the modifier .animation(.default) to a view, SwiftUI will automatically animate any chanes that happen to that view using whatever is the default system animation. In practice, that is an "ease in, ease out" animation, which means iOS will start the animation slow, make it pick up speed, then slow down as it approaches its end.

//We can control the type of animation used by passing in different values to the modifier. For example, we could use .easeOUt to make the animiation start fast then slow down to a smooth stop:

//.animation(.easeOut)

//There are even spring animations, that cause the movement to overshoot then return to settle at its targer. You can control the initisal stiffness of the spring (which sets the initial velocity when the animation starts), and how fast the animation should be "damped" - lower values cause the spring to bounce back and forth for longer.

//For example, this makes our button scale up quickly then bounce:

//.animation(interpolatingSpring(stiffness: 50, damping: 1))

//For more precise control, we can customize the animation with a duration specified as a number of seconds. So, we could get an ease-in-out animation that lasts for two seconds like this:

/*
 struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
 
    var body: some View {
        Button("Tap Me") {
            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(.easeInOut(duration: 2)
 */

//When we say .easeInOut(duration: 2) we're acutally createing an instance of an Animation struct that has its own set of modifiers. So, we can attach modifiers directly to the animation to add a delay lkke this:

/*
 .animation(
        Animation.easeInOut(duration: 2)
            .delay(1)
 )
 */

//You'll notice that we explicitly have to say Animation.easeIntOUt() now, because otherwise SWift isn't quite sure what we mean. Regardless, tapping the button will now wait for a second before executing a two-second animation.

//We can also ask the animation to repeat a certain number of times, and even make it bounce back and forwwrd by setting autoreverses to true. This creates a one-second animation that will bounce up and down before reaching its final size:

/*
 .animation(
    Animation.easeInOut(duration: 1)
        .repeatCount(3, autoreverses: true)
 )
 */

//If we had set repeat count to 2 then the button would scale up then down again, the jump immediately back to its larger scale. This is because ultimately the button must match the state of our program, regardless of what animations we apply - when the animation finishes the button must have whatever value is set in animationAmount.

//For continuous animations, there is a repeatForever() modifier that can be used like this:

/*
 .animation)
    Animation.easeInOut(duration: 1)
        .repeatForever(autoreverses: true)
 )
 */

//We can use these repeatForever() animations in combination with onAppear() to make animations that start immediately and continue animating for the life of the view.

//To demonstrate this, we're going to remove the animation from the button itself and instead apply it an overlay to make a sort of pulsating circle around the button.

//So, first add this overlay() modifier to the button:

/*
 .overlay(
    Circle()
        .stroke(Color.red)
        .scaleEffect(animationAmount)
        .opacity(Double(2 - animationAmount))
 )
 */

//That makes a stroked red circle button, using an opacity value of 2 - animationAmount so that when animationAmount is 1 the opacity is 1 (it's opaque) and when animationAmount is 2 the opacity is 0 (it's transparent).

//Next, remove the scaleEffect() modifier from the button and comment out the animationAmount += 1 action part too, because we don't want that to change any more, and move its animation madifier up to the circle inside the overlay:

/*
 overlay(
    Circle()
        .stroke(Color.red)
        .scaleEffect()
        .opacity(Double(2 - animationAmount))
        .animation.easeOut(duration: 1)
            .repeatForever(autoreverses: false)
 
 */

//I've switched autoreverses to false, but otherwise it's the same animation.

//Finally, addd an onAppear() modifier to the button, which will set the animationAmount to 2:

/*
 .onAppear {
    self.animationAmount = 2
 }
 */

//Because the ovelay circle uses that for a "repeat forever" animation without autoreversing, you'll see the overlay circle scalu up and fade continuously.

//Your fininshed code should look like this:
/*
 Button("Tap Me") {
    //self.animationAmount += 1
 }
 .padding(40)
 .background(Color.red)
 .foregroundColor(.white)
 .clipshape(Circle())
 .overlay(
    Circle()
        .stroke(Color.red)
        .scaleEffect(animationAmount)
        .opacity(Double(2 - animationAmount))
        .animation(
            Animation.easeOut(duration: 1)
                .repeatForever(autoreverses: false)
        )
 )
 .onAppear {
    self.animationAmount = 2
 }
 */
//MARK: 4. Animating Bindings

//MARK: 5. Creating Explicit Animations
