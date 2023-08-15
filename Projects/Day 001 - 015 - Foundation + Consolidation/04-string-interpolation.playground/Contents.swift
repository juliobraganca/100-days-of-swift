// MARK: 4. String Interpolation

import UIKit

// This is a fancy name for what is actually a very simple thing: combining variables and constants inside a string.

var name = "Tim McGrow"
"your name is \(name)"

//it can be done in the following way, but is not efficient
"your name is " + name

// can be used with different types as well
var age = 25
var latitude = 36.16667

"Your name is \(name), your age is \(age), and your latitude is \(latitude)"
// doing this using + is not possible because you cannot put strings and other types together

// it's possible to do math inside the string interpolation
"Your age is \(age) years old. In another \(age) years you will be \(age * 2)."
