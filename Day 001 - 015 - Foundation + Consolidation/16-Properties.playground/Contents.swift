// MARK: 16. Properties

import UIKit

// Structs and classes (collectively: "types") can have their own variables and constants, and these are called properties.
// These let you attach values to your types to represent them uniquely, but because types can also have methods you can have them behave according to their own data.

struct Person {
    var clothes: String
    var shoes: String

    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}

let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")

taylor.describe()
other.describe()

// MARK: Property observers
// There are two kinds of property observer: willSet and didSet


// Let's attach two property observers to the clothes property of a Person struct:
struct Person2 {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")   // WillSet -  Swift provides your code with a special value called newValue that contains what the new property value is going to be
        }

        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")  // DidSet - you are given oldValue to represent the previous value.
        }
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor2 = Person2(clothes: "T-shirts")
taylor2.clothes = "short skirts"


// MARK: Computed properties
// It's possible to make properties that are actually code behind the scenes.

// For example, if we wanted to add a ageInDogYears property that automatically returned a person's age multiplied by seven, we'd do this:
struct Person {
    var age: Int

    var ageInDogYears: Int {
        get {
            
            return age * 7
        }
    }
}

var fan = Person(age: 25)
print(fan.ageInDogYears)

//Note: If you intend to use them only for reading data you can just remove the get part entirely, like this:
    //var ageInDogYears: Int {
        //return age * 7
    //}

