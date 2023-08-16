// 20. Closures

import UIKit
import SwiftUI

// A closure can be thought of as a variable that holds code. So, where an integer holds "0" or "500", a closure holds lines of Swift code.

// Here’s an example from SwiftUI:

let message = "Button pressed"

Button("Press Me", action: {
    print(message)
})

// Button is one of the many user interface controls we have in SwiftUI, and provides something that user can press on to execute some sort of action.

// In this code, creating a button takes two parameters: some text to show as the button’s title, and a closure containing the code to be executed when the button is pressed. I've specified “Press Me” for the first parameter, and for the second I've made the system print a message string.

// This method needs to use a closure because SwiftUI won’t run the code until the button is pressed – it will stash the action code away for later on, then call it only when needed. This wouldn't be possible if we just ran our code directly.

// The above code also shows how closures capture their environment: I intentionally declared the message constant outside of the closure, then used it inside. Swift detects this, and makes that data available inside the closure too.

// Swift's system of automatically capturing a closure's environment is very helpful, but can occasionally trip you up: if object A stores a closure as a property, and that property also references object A, you have something called a retain cycle and you'll have unhappy users. This is a substantially more advanced topic than you need to know right now, so don't worry too much about it just yet.


// MARK: Trailing closures

// As closures are used so frequently, Swift can apply a little syntactic sugar to make your code easier to read. The rule is this: if the last parameters to a method are closures, you can eliminate those parameters and instead provide them as a block of code inside braces. For example, we could convert the previous code to this:

let message2 = "Button pressed"

Button("Press Me") {
    print(message2)
}

// It does make your code shorter and easier to read, so this syntax form – known as trailing closure syntax – is preferred.

// A function can have multiple trailing closures if needed, and this is particularly common in SwiftUI. For example, one way to create a button is to provide code to run when it’s pressed as the first closure, then something custom to show inside the button on the screen, like this:

Button {
    print("The button was pressed")
} label: {
    Image("press-me")
}

// That uses an image rather than a simple piece of text, but it could be any kind of SwiftUI user interface control.
