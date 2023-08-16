// MARK: 11. Optionals

import UIKit

// Swift is a very safe language, by which I mean it works hard to ensure your code never fails in surprising ways.
// Optionals are "no value" or nill

// Consider the example below, which we want to check if a album is from Taylor Swift:
func yearAlbumReleased(name: String) -> Int {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }

    return 0 // That takes the name of a Taylor Swift album, and returns the year it was released. But if we call it with the album name "Lantern" because we mixed up Taylor Swift with Hudson Mohawke then it returns 0 because it's not one of Taylor's albums.
    
}

// But does 0 make sense here? people need to know ahead of time that 0 means “not recognized.”
// A much better idea is to rewrite that function so that it either returns an integer (when a year was found) or nil (when nothing was found), which is easy thanks to optionals. Here's the new function:
func yearAlbumReleased2(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }

    return nil
}

yearAlbumReleased(name: "Lantern")

// Now that it returns nil, we need to unwrap the result using if let because we need to check whether a value exists or not.
//if let unwrappedStatus = status {
    // unwrappedStatus contains a non-optional value!
//} else {
    // in case you want an else block, here you go…
//}

// When you work with these "might be there, might not be" values, Swift forces you to unwrap them before using them, thus acknowledging that there might not be a value. That's what if let syntax does: if the optional has a value then unwrap it and use it, otherwise don't use it at all. You can’t use a possibly-empty value by accident, because Swift won’t let you.


// MARK: Another Example

func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}

if let haterStatus = getHaterStatus(weather: "rainy") {
    takeHaterAction(status: haterStatus)
}


// MARK: Force Unwrapping

func yearAlbumReleased3(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006}
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }

    return nil
}

var year = yearAlbumReleased3(name: "Taylor Swift")

if year == nil {
    print("There was an error")
} else {
    print("It was released in \(year)") // Well, yearAlbumReleased() returns an optional integer, and this code doesn't use if let to unwrap that optional. As a result, it will print out the following: "It was released in Optional(2012)" – probably not what we wanted!
}

// At this point in the code, we have already checked that we have a valid value, so it's a bit pointless to have another if let in there to safely unwrap the optional. So, Swift provides a solution – change the second print() call to this:

if year == nil {
    print("There was an error")
} else {
    print("It was released in \(year!)")
}
// Note the exclamation mark: it means "I'm certain this contains a value, so force unwrap it now."


// MARK: Implicitly unwrapped optionals

var name: String = "Paul" //that must contain a string, even if the string is empity, it can't be nill
var name2: String? = "Bob" //it might contain a string, or might not. If you want to find if Bob is in there, you need to unwrap it.
var name3: String! = "Sophie" // Implicitly unwrapped optionals migh contain a value or not, but swift won't check it for you. if you use it you have to be 100% sure it has a value, if not your app will crash.
