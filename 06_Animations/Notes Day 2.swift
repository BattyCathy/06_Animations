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

//SwiftUI lets us attach gestures to any views, and the effects of those gestures can also be animated. We'll be looking at gestures in more detail later on, but for now let's try something relatively simple: a card that we can drag around the screen, but when we go it snaps back into its original location.

//First, our initial layout:

/*
 Struct ContentView: View {
    var body: some View {
        LinearGradient(graident: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
 }
 */

//That draws a card-like view in the center of the screen. We want to move that around the screen based on the location of our finger, and that requires three steps.

//First, we need some state to store the amount of their drag:

//@State private var dragAmount = CGSize.zero

//Second, we want to use that size to influence the card's position on-screen. SwiftUI gives us a dedicated modifier for this called offset(), which lets us adjust the X and Y coordinate of a view without moving other views around it. You can pass in discrete X and Y coordinates if you want to, but - by no mere coincidence - offset() can also take a CGSize directly.

//So, step two is to add this modifier to the card gradient:

//.offset(dragAmount)

//Now comes the important part: we can create a DragGesture and attach it to the card. Drag gestures have two extra modifiers that are useful to us fere: onChanged() lets us run a closure whenever the user moves their finger, and onEnded() lets us run a closure when the user lifts their finger off the screen, ending the drag.

//Both of those closrue are given a single parameter, which describes the drag operation - where it started, where it is currently, how far it moved, and so one. For our onChanged() modifier we're going to read the translation of the drag, which tells us how far it's moved from the start point - we can addign that directly to dragAmount so that our view moves along with the gesture. For onEnded() we're going to ignore the input entirely, because we'll be setting dragAmount back to zero.

//So, add this modifier to the linear gradient now:

/*
 .gesture(
    DragGesture()
        .onChanged { self.dragAmount = $0.translation }
        .onEnded { _ in slef.dragAmount = .zero }
 }
 */

//If you run the code you'll see you can now drag the gradient card around, and when you released the drag it will jump back to the center. The card has its offset determined by dragAmount, which in turn is being set by the drag gesture.

//Now that everything works, we can bring that movement to life with some animation, and we have two options: add an implicit animation that will animate the drag and the release, or add an explicit animation to animate just the release.

//To see the former in action, add this modifier to the linear gradient:

//.animation(.spring())

//As you drag around, the card will move to the drag location with a slight delay because of the spring animation, but it will also gently overshoot if you make sudden movements.

//To se explicit animations in action, remove that animation() modifier and change your existing onEnded() drag gesture code to this:

/*
 .onEnded { _ in
    withAnimation(.spring()) {
        self.dragAmount = .zero
    }
 }
 */

//Now the card will follow your drag immediately (because that's not being animated), but when you release it will animate.

//If we combine offset animations with drag gestures and a little delay, we can create remarkable fun animations without a lot of code.

//To demonstrate this, we could write the text "Hello SwiftUI" as a series of individual letters, each one with a background color and offset that is controlled by some state. Strings are just slightly fancy arrays of characters, so we can get a real array from a string like this: Array("Hello SwiftUI")

//Anyway, try this our and see what you think:

/*struct ContentView: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
 
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .paddint(5)
                    .font(.title)
                    .background(slef.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
        }
    }
    .gesture(
        DragGesture()
            .onChanged { self.dragAmount = $0.translation }
            .onEnded { _ in
                self.dragAmount = .zero
                self.enabled.toggle()
            }
    )
    }
 }
 
 */

//If you run that code you'll see that any letter can be dragged around to have the whole string follow suit, with a brief delay causing a snake-like effect. SwiftUI will also add in color changing as you release the drag, animating between blue and red even as letters move back to the center.


//MARK: 3. Showing and Hiding Views with Transitions

//One of the most powerful feature of SwiftUI is the ability to customize the way views are shown and hidden. Previously you've seen how we can use regular if conditions to include views conditionally, which means when that condition changes we can insert or remove views from our view hierarchy.

//Transitions control how this insertion and removal takes place, and we can work with the built =-in transitions, combine them in different ways, or even create wholly custom transitions.

//To demostrate this, here's a VStack with a button and a rectangle:

/*
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
 */


//We can make the rectangle appear only when a certain condition is satisfied. First, we add some state we can manipulate:

//@State private var isShowingRed = false

//Next we use that state as a condition for showing our rectangle:

/*
 if isShowingRed {
    Rectangle()
        .fill(Color.red)
        .frame(width: 200, height: 200)
 }
 */

//Finally, we can toggle isShowingRed between true and false in the button's action:

//self.isShowingRed.toggle()

//If you run the program, you'll see that pressing the button shows and hides the red square. There's no animation; it just appears and disappears abruptly.

//We can get SwiftUI's default view transition by wrapping the state change using withAnimation(), like this:

/*
 withAnimation {
    self.isShowingRed.toggle()
 */

//With that small change, the app now fades the red retangle in and out, while also moving the button up to make space. It looks OK, but we can do better with the transition() modifier.

//For example, we could have the rectangle scale up and down as it is shown just by adding the transition() modifier to it:

/*
 Rectangle()
    .fill(Color.red)
    .frame(width: 200, height: 200)
    .transition(.scale)
 */
//MARK: 4. Building Custom Transitions Using ViewModifier
