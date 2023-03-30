import UIKit

// MARK: 2. TYPES OF DATA

// MARK: Strings - Strings can be long (e.g. a million letters or more), short (e.g. 10 letters) or even empty (no letters), it doesn't matter: they are all strings in Swift's eyes, and all work the same

var name = "Tim McGraw"

// MARK: Type annotations - to specify the type of variable before defining it

var name2: String
name2 = "Tim McGraw"

// MARK: Int - Integers are round numbers like 3, 30, 300, or -16777216

var age: Int
age = 25

// if you try to put a int in name and str in age xCode will give you an error due to type safety
// CODE: name = 25
// CODE: age = "Tim McGraw"

// MARK: float and double - This is Swift's way of storing numbers with a fractional component, such as 3.1, 3.141, 3.1415926, and -16777216.5. There are two data types for this because you get to choose how much accuracy you want, but most of the time it doesn't matter so the official Apple recommendation is always to use Double because it has the highest accuracy.


var longitude: Float
longitude = -186.783333
longitude = -111186.783333
// the float has less accuracy. it will sacrifice decimal points

var latitude: Double
latitude = 36.166667
latitude = 3644444444.166667
latitude = 364444394735722884.166667
//doubles are way more accurate than float, but it has limits if you try a very big number.

// MARK: Bool - data type that can store whether a value is true or false, short for Boolean

var stayOutTooLate: Bool
stayOutTooLate = true

var nothingInBrain: Bool
nothingInBrain = true

var missABeat: Bool
missABeat = false

// MARK: It's preferable not use type annotation if you have the choice, it's called type inference

var name3 = "Tim McGraw"

// you can provide type and the value at the same time

var name4: String = "Tim McGraw"
