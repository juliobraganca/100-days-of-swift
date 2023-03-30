// MARK: 7. Conditional Statements

import UIKit

// if and else - you give swift a condition, then a block of code to execute if that condition is true.

var action: String
var person = "hater"

if person == "hater" {
    action = "hate"
}

// Adding else if and else blocks:
if person == "hater" {
    action = "hate"
} else if person == "player" { //another condition
    action = "play"
} else {
    action = "cruise" //if neither is true
}

// MARK: Evaluating multiple conditions

// Swift can be asked to run as many conditions as you want, but they all need to be true in order for Swift to execute the block of code:
var action2: String
var stayOutTooLate = true
var nothingInBrain = true

if stayOutTooLate && nothingInBrain { //it's not necessary to type '== true'
    action2 = "cruise"
}

// MARK: Looking for the opposite of truth

// sometimes you care whether a condition is not true, i.e. is false. You can do this with the ! (not) operator that was introduced earlier.
if !stayOutTooLate && !nothingInBrain {
    action2 = "cruise"
}

