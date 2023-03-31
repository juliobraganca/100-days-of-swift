// MARK: 15. Classes

import UIKit

// Swift has another way of building complex data types called classes. They look similar to structs, but have a number of important differences, including:

// * INITIALIZERS: You don't get an automatic memberwise initializer for your classes; you need to write your own.
// * CLASS INHERITANCE: You can define a class as being based off another class, adding any new things you want.
// * When you create an instance of a class it’s called an object. If you copy that object, both copies point at the same data by default – change one, and the copy changes too. (Different than the taylor copy example)

// MARK: Initializing an object
// If we were to convert our Person struct into a Person class, Swift wouldn't let us write this:
// Code: class Person {
    // var clothes: String
    // var shoes: String
// }

// This is because we're declaring the two properties to be String, which if you remember means they absolutely must have a value.
// This was fine in a struct because Swift automatically produces a memberwise initializer for us that forced us to provide values for the two properties, but this doesn't happen with classes so Swift can't be sure they will be given values.

// There are three solutions: make the two values optional strings, give them default values, or write our own initializer.
    // The first option is clumsy because it introduces optionals all over our code where they don't need to be.
    // The second option works, but it's a bit wasteful unless those default values will actually be used.
    // That leaves the third option, and really it's the right one: write our own initializer.

// To do this, create a method inside the class called init() that takes the two parameters we care about:
class Person {
    var clothes: String
    var shoes: String

    init(clothes: String, shoes: String) { // you don't write func here because it's special.
        self.clothes = clothes // because the parameter names being passed in are the same as the names of the properties we want to assign, you use self. You can give them unique names if you want.
        self.shoes = shoes
    }
}


// MARK: Class Inheritance
// classes can build on each other to produce greater things, known as class inheritance.


// Let's start with something simple: a Singer class that has properties, which is their name and age. As for methods, there will be a simple initializer to handle setting the properties, plus a sing() method that outputs some words:
class Singer {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func sing() {
        print("La la la la")
    }
}


// We can now create an instance of that object by calling that initializer, then read out its properties and call its method:
var taylor = Singer(name: "Taylor", age: 25)
taylor.name
taylor.age
taylor.sing()


// That's our basic class, but we're going to build on it: I want to define a CountrySinger class that has everything the Singer class does, but when I call sing() on it I want to print "Trucks, guitars, and liquor" instead.
// We want it to have its own sing() method, but in Swift you need to learn a new keyword: override. This means "I know this method was implemented by my parent class, but I want to change it for this subclass."

class CountrySinger: Singer { // That colon is what does the magic: it means "CountrySinger extends Singer." Now, that new CountrySinger class (called a subclass) doesn't add anything to Singer (called the parent class, or superclass) yet.
    override func sing() {                         // it overrides the func from the parent class to print this when it's a country singer
        print("Trucks, guitars, and liquor")
    }
}

var taylor2 = CountrySinger(name: "Taylor", age: 25)
taylor2.sing()

// MARK: New class with a new property
//

class HeavyMetalSinger: Singer {
    var noiseLevel: Int // we need to set our own property first (noiseLevel) then pass on the other parameters for the superclass to use.

    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel
        super.init(name: name, age: age) // super is used to call a method on the class I inherited from the super class. It's usually used to "let my parent class do everything it needs to do first, then I'll do my extra bits."
    }

    override func sing() {
        print("Grrrrr rargh rargh rarrrrgh!")
    }
}

// class inheritance often spans many levels. For example, A could inherit from B, and B could inherit from C, and C could inherit from D, and so on.
// This lets you build functionality and re-use up over a number of classes, helping to keep your code modular and easy to understand.

