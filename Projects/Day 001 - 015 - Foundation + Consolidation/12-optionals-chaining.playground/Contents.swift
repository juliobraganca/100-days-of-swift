// MARK: 12. Optionals Chaining

import UIKit

// Swift has two techniques to help make your code less complicated. The first is called optional chaining, which lets you run code only if your optional has a value. Put the below code into your playground to get us started:

func albumReleased(year: Int) -> String? {
    switch year {
    case 2006: return "Taylor Swift"
    case 2008: return "Fearless"
    case 2010: return "Speak Now"
    case 2012: return "Red"
    case 2014: return "1989"
    default: return nil
    }
}

let album = albumReleased(year: 2006)
print("The album is \(album)")
// That will output "The album is Optional("Taylor Swift")" into the results pane.


// If we wanted to convert the return value of albumReleased() to be uppercase letters (that is, "TAYLOR SWIFT" rather than "Taylor Swift") we could call the uppercased() method of that string.
// The problem is, albumReleased() returns an optional string: it might return a string or it might return nothing at all. So, what we really mean is, "if we got a string back make it uppercase, otherwise do nothing." And that's where optional chaining comes in, because it provides exactly that behavior.
let album2 = albumReleased(year: 2006)?.uppercased() // everything after the question mark will only be run if everything before the question mark has a value.
print("The album is \(album2)")

// Your optional chains can be as long as you need, for example:
// CODE: let album = albumReleased(year: 2006)?.someOptionalValue?.someOtherOptionalValue?.whatever // Swift will check them from left to right until it finds nil, at which point it stops.


// MARK: The nil coalescing operator
// What it does is let you say "use value A if you can, but if value A is nil then use value B."

let album3 = albumReleased(year: 2006) ?? "unknown" //if album3 returns a value use it in the print value, if return nill uses unknown instead
print("The album is \(album3)")
