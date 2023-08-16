// MARK: 14. Structs

import UIKit

// Structs are complex data types, meaning that they are made up of multiple values.
// You then create an instance of the struct and fill in its values, then you can pass it around as a single value in your code.

// for example, let's create a Person struct with two properties: Clothes and shoes:

struct Person {
    var clothes: String
    var shoes: String
}

let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")

print(taylor.clothes)
print(other.shoes)

var taylorCopy = taylor
taylorCopy.shoes = "flip flops" //it creates a third person taylorCopy as a copy of taylor

print(taylor)
print(taylorCopy) // If you look in your results pane (you might need to resize it to fit) you'll see that the copy has a different value to the original: changing one did not change the other.

// MARK: Functions inside structs
//You can place functions inside structs, and in fact it’s a good idea to do so for all functions that read or change data inside the struct.

//For example, we could add a function to our Person struct to describe what they are wearing, like this:
struct Person2 {
    var clothes: String
    var shoes: String

    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}

// when you write a function inside a struct, it's called a method instead. In Swift you write func whether it's a function or a method, but the distinction is preserved when you talk about them.
