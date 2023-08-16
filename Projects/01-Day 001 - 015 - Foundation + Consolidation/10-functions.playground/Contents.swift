// 10. Functions

import UIKit

//Functions let you define re-usable pieces of code that perform specific pieces of functionality. It's good for things that repeats along your code so you don't need to change all of them, you only change the function.

func favoriteAlbum (){
    print("My favorite is Fearless")
}

favoriteAlbum()

// functions accepting parameters:
func favoriteAlbum2 (name: String){
    print("My favorite is \(name)")
}

favoriteAlbum2(name: "Fearless")

// it can accept multiple parameters:

func printAlbumRelease(name: String, year: Int) {
    print("\(name) was released in \(year)")
}

printAlbumRelease(name: "Fearless", year: 2008)


// MARK: External and internal parameter names
// Sometimes you want parameters to be named one way when the function is called, but another way inside the function itself

// To demonstrate this, let’s write a function that prints the number of letters in a string. This is available using the count property of strings, so we could write this:
func countLettersInString(string: String) {
    print("The string \(string) has \(string.count) letters.")
}

countLettersInString(string: "Hello")


// we can change the function for the following
func countLettersInString2(myString str: String) { //now myString is used externally (when calling the function) and str is using internally.
    print("The string \(str) has \(str.count) letters.")
}

countLettersInString2(myString: "Hello")

// It can be simplified by:
func countLettersInString3(_ str: String) { //now you can only type the string externally and str is used internally again.
    print("The string \(str) has \(str.count) letters.")
}

countLettersInString3("Hello")

// usually devs uses "in" or other words to be more natural to read, like the following:
func countLetters(in string: String) {
    print("The string \(string) has \(string.count) letters.")
}

countLetters(in: "Hello")


// MARK: Returns
// you can also say to functions to return values by writing ->

func albumIsTaylor(name: String) -> Bool {
    if name == "Taylor Swift" { return true }
    if name == "Fearless" { return true }
    if name == "Speak Now" { return true }
    if name == "Red" { return true }
    if name == "1989" { return true }

    return false
}

//since the function will retorn a Bool, you can print the following, considering the return:
if albumIsTaylor(name: "Red") {
    print("That's one of hers!")
} else {
    print("Who made that?!")
}

if albumIsTaylor(name: "Blue") {
    print("That's one of hers!")
} else {
    print("Who made that?!")
}


// BONUS: If your function returns a value and has only one line of code inside it, you can omit the return keyword entirely – Swift knows a value must be sent back, and because there is only one line that must be the one that sends back a value. For example, we could write this:

func getMeaningOfLife() -> Int {
    return 42
}

// Or we could just write this:

func getMeaningOfLife2() -> Int {
    42
}
