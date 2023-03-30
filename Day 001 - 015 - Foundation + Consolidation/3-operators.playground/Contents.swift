// MARK: 3. Operators

import UIKit

// MARK: + to add, - to subtract, * to multiply, / to divide, = to assign value

var a = 10
a = a + 1
a = a - 1
a = a * a

var b = 10
b += 10
b -= 10


// with doubles

var a1 = 1.1
var b1 = 2.2
var c1 = a + b

// with strings

var name1 = "Tim McGraw"
var name2 = "Romeo"
var both = name1 + " and " + name2

// MARK: %
// One more common operator you’ll see is called modulus, and is written using a percent symbol: %. It means “divide the left hand number evenly by the right, and return the remainder.” So, 9 % 3 returns 0 because 3 divides evenly into 9, whereas 10 % 3 returns 1, because 10 divides by 3 three times, with remainder 1.

9 % 3
10 % 3

// MARK: Comparison operators

var a2 = 1.1
var b2 = 2.2
var c2 = a + b

c2 > 3
c2 >= 3
c2 > 4
c2 < 4

name1 == "Tim McGraw"
name1 == "TIM McGraw"
// Strings are case sensitive
name1 != "TIM MacGraw"
// !=  is not equal


var stayOutTooLate = true
stayOutTooLate
!stayOutTooLate
// the "not" opperator - makes the opposite of the Bool
