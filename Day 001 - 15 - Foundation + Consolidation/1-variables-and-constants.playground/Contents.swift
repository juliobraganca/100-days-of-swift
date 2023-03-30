import UIKit

// MARK: 1. VARIABLES AND CONSTANTS

// Variables (var) can be changed and Constants (let) can't
// Swift does not let us change a constant

var name = "Tim McGrow"
name = "Romeo"

let nameConstant = "Tim McGrow"

// Constants - Swifts displays an error if you try to change it

let name2 = "Tim McGrow"
// ERROR: name2 = "Romeo"

// Variable and constant names must be unique in your code. You'll get an error if you try to use the same variable name twice, like this:

var name3 = "Tim McGraw"
// ERROR: var name3 = "Romeo"
