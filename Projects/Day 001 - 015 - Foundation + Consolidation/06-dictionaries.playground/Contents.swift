// MARK: 6. Dictionaries

import UIKit

// Dictionaries are another type of collection, but works with a 'key' instead of a 'index' like arrays

// Arrays vs Dictionaries
// To give an example, let's imagine how we might store data about a person:

var personArray = ["Taylor", "Alison", "Swift", "December", "taylorswift.com"]
// To read out that person's middle name, we'd use person[1], and to read out the month they were born we'd use person[3].

var personDic = ["first": "Taylor", "middle": "Alison", "last": "Swift", "month": "December", "website": "taylorswift.com"]
personDic["middle"]
personDic["month"]
// it's wy easier to read out from a dictionary in this case


// It might help if I use lots of whitespace to break up the dictionary on your screen, like this:
var person = [
                "first": "Taylor",
                "middle": "Alison",
                "last": "Swift",
                "month": "December",
                "website": "taylorswift.com"
            ]

person["middle"]
person["month"]

// As with arrays, you can store a wide variety of values inside dictionaries, although the keys are most commonly strings.
