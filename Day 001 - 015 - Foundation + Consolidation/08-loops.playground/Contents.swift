// MARK: 8. Loops

import UIKit

// loops are simple programming constructs that repeat a block of code for as long as a condition is true.
print("1 x 10 is \(1 * 10)")
print("2 x 10 is \(2 * 10)")
print("3 x 10 is \(3 * 10)")
print("4 x 10 is \(4 * 10)")
print("5 x 10 is \(5 * 10)")
print("6 x 10 is \(6 * 10)")
print("7 x 10 is \(7 * 10)")
print("8 x 10 is \(8 * 10)")
print("9 x 10 is \(9 * 10)")
print("10 x 10 is \(10 * 10)")

// Using the closed range operator, we could re-write that whole thing in three lines:
for i in 1...10 {
    print("\(i) x 10 is \(i * 10)")
}

// If you don't need to know what number you're on, you can use an underscore instead. For example, we could print some Taylor Swift lyrics like this:
var str = "Fakers gonna"

for _ in 1...5 {
    str += " fake"
}

print(str)
// If Swift doesn’t have to assign each number to a variable each time the loop goes around, it can run your code a little faster. As a result, if you write for i in… then don’t use i, Xcode will suggest you change it to _.


// The half open range operator looks like ..< and counts from one number up to and excluding another. For example, 1..<5 will count 1, 2, 3, 4.
print ("Count Says:")
for num in 1..<5 {
    print(num)
}


// MARK: Looping over arrays

var songs = ["Shake it Off", "You Belong with Me", "Look What You Made Me Do"]

for song in songs {
    print("My favorite song is \(song)")
}


// You can also use the for i in loop construct to loop through arrays, because you can use that constant to index into an array. We could even use it to index into two arrays, like this:
var people = ["players", "haters", "heart-breakers", "fakers"]
var actions = ["play", "hate", "break", "fake"]

for i in 0...3 {
    print("\(people[i]) gonna \(actions[i])")
}


// To count how many items are in an array, use someArray.count. So, we could rewrite our code like this:

var people2 = ["players", "haters", "heart-breakers", "fakers"]
var actions2 = ["play", "hate", "break", "fake"]

for i in 0..<people2.count { // rather than counting from 0 up to and including 3, we could count from 0 up to and excluding the number of items in an array.
    print("\(people2[i]) gonna \(actions2[i])")
}

// MARK: Inner Loops

var people3 = ["players", "haters", "heart-breakers", "fakers"]
var actions3 = ["play", "hate", "break", "fake"]

for i in 0..<people3.count {
    var str = "\(actions3[i])"
    
    for _ in 1...5 {
        str += " \(actions3[i])"
    }
    
    print(str)
}

// MARK: While Loops
// There's a third kind of loop you'll see, which repeats a block of code until you tell it to stop.
// This is used for things like game loops where you have no idea in advance how long the game will last – you just keep repeating "check for touches, animate robots, draw screen, check for touches…" and so on, until eventually the user taps a button to exit the game and go back to the main menu.

var counter = 0

while true {
    print("Counter is now \(counter)")
    counter += 1

    if counter == 556 {
        break // it will run until 556 and then it will 'break'
    }
}

// MARK: using continue to skip an item

var songs2 = ["Shake it Off", "You Belong with Me", "Look What You Made Me Do"]

for song in songs2 {
    if song == "You Belong with Me" {
        continue //it will not consider the 'You Belong with Me" and continue the loop to the next item
    }
    
    print("My favorite song is \(song)")
}
