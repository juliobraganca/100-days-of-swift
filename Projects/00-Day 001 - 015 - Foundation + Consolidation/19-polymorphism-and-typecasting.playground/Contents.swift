// MARK: 19. Polymorphism and typecasting

import UIKit

// MARK: Polymorphism
// Because classes can inherit from each other (e.g. CountrySinger can inherit from Singer) it means one class is effectively a superset of another: class B has all the things A has, with a few extras.
// This in turn means that you can treat B as type B or as type A, depending on your needs.

class Album {
    var name: String

    init(name: String) {
        self.name = name
    }

    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String

    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String

    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

// That defines three classes: albums, studio albums and live albums, with the latter two both inheriting from Album. Because any instance of LiveAlbum is inherited from Album it can be treated just as either Album or LiveAlbum – it's both at the same time. This is called "polymorphism," but it means you can write code like this:

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive] // There we create an array that holds only albums, but put inside it two studio albums and a live album.

// it can be used with functions as well:

for album in allAlbums {
    print(album.getPerformance()) //That will automatically use the override version of getPerformance() depending on the subclass in question. That's polymorphism in action: an object can work as its class and its parent classes, all at the same time.
}


// MARK: Typecasting
// You will often find you have an object of a certain type, but really you know it's a different type. Sadly, if Swift doesn't know what you know, it won't build your code.
// So, there's a solution, and it's called typecasting: converting an object of one type to another.

for album2 in allAlbums {
    print(album2.getPerformance()) // if you try to write something like print(album.studio) it will refuse to build because only StudioAlbum objects have that property.
}

// Typecasting in Swift comes in three forms, but most of the time you'll only meet two:
    // * as? (optional downcasting) - "I think this conversion might be true, but it might fail,"
    // * as! (forced downcasting) - "I know this conversion is true, and I'm happy for my app to crash if I'm wrong."

// Example 1:
for album3 in allAlbums {
    let studioAlbum = album3 as? StudioAlbum // Swift will make studioAlbum have the data type StudioAlbum?. That is, an optional studio album: the conversion might have worked, in which case you have a studio album you can work with, or it might have failed, in which case you have nil.
}

// This is most commonly used with if let to automatically unwrap the optional result, like this:
for album4 in allAlbums {
    print(album4.getPerformance())

    if let studioAlbum = album4 as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album4 as? LiveAlbum {
        print(liveAlbum.location)
    }
}

// Forced downcasting is when you're really sure an object of one type can be treated like a different type, but if you're wrong your program will just crash. For example:
var allAlbums2: [Album] = [taylorSwift, fearless]

for album5 in allAlbums2 {
    let studioAlbum = album5 as! StudioAlbum
    print(studioAlbum.studio)
}
// That's obviously a contrived example, because if that really were your code you would just change allAlbums so that it had the data type [StudioAlbum]. Still, it shows how forced downcasting works, and the example won't crash because it makes the correct assumptions.


// Swift lets you downcast as part of the array loop, which in this case would be more efficient. If you wanted to write that forced downcast at the array level, you would write this:

for album6 in allAlbums2 as! [StudioAlbum] {
    print(album6.studio)
}

// Swift also allows optional downcasting at the array level, although it's a bit more tricksy because you need to use the nil coalescing operator to ensure there's always a value for the loop. Here's an example:

// for album in allAlbums as? [LiveAlbum] ?? [LiveAlbum]() {
   // print(album.location)
// }

// MARK: When typecasting is useful - Converting common types with initializers
// Typecasting is useful when you know something that Swift doesn’t, for example when you have an object of type A that Swift thinks is actually type B.
// However, typecasting is useful only when those types really are what you say – you can’t force a type A into a type Z if they aren’t actually related.

// let number = 5
// let text = number as! String // if you have an integer called number, you couldn’t write code like this to make it a string

// that code should be rewritten like this:
let number = 5
let text = String(number)
print(text)

// This only works for some of Swift’s built-in data types: you can convert integers and floats to strings and back again, for example, but if you created two custom structs Swift can’t magically convert one to the other – you need to write that code yourself.
