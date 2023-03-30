// MARK: 5.Arrays

import UIKit

// Arrays let you group lots of values together into a single collection, then access those values by their position in the collection. Swift uses type inference to figure out what type of data your array holds, like so:

var evenNumbers = [2, 4, 6, 8]
var songs = ["Shake it Off", "You Belong with Me", "Back to December"]


// you can read any item from the array providing the index. The first position of the array is 0.
songs[0]
songs[1]
songs[2]

type(of: songs)


// if you try to include another type in the array swift will return an error
// CODE: var songs2 = ["Shake it Off", "You Belong with Me", "Back to December", 3]


// type annotation can be used, if you want to use only strings you specify it or you can use any if you want to hold any type in the array, like in the example:
// CODE: var songs3: [String] = ["Shake it Off", "You Belong with Me", "Back to December", 3]
var songs4: [Any] = ["Shake it Off", "You Belong with Me", "Back to December", 3]


// If you make an array using the syntax shown above, Swift creates the array and fills it with the values we specified. Things aren't quite so straightforward if you want to create the array then fill it later – this syntax doesn't work:
//CODE: var songs5: [String]
//CODE: songs5[0] = "Shake it Off"

// There are a few ways to express this correctly, and the one that probably makes most sense at this time is this:
var songs6: [String] = []
var songs7 = [String]() //more used

// how to add items will be covered later

// MARK: Array operators

// you can merge two arrays by using the + operator, like this:
var songs8 = ["Shake it Off", "You Belong with Me", "Love Story"]
var songs9 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var both = songs8 + songs9
print(both)

// You can also use += to add and assign, like this:
both += ["Everything has Changed"]
print(both)
