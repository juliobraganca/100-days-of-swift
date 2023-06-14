import UIKit

let name = "Taylor"

for letter in name {
    print("Give me a \(letter)")
}

// print(name[3]) - it does not work

let letter = name[name.index(name.startIndex, offsetBy: 3)]

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

// reading name.count isn’t a quick operation: Swift literally needs to go over every letter counting up however many there are, before returning that. As a result, it’s always better to use someString.isEmpty rather than someString.count == 0 if you’re looking for an empty string.

let password = "12345"
password.hasPrefix("123")
password.hasSuffix("345")

extension String {
    // remove a prefix if it exists
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    //remove a suffix if it exists
    func deletingSuffix(_ suffix:String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}

let weather = "it's going to rain"
print(weather.capitalized)

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}

print(weather.capitalizedFirst)

let input = "Swift is like Objective-C without the C"
input.contains("Swift")


let languages = ["Python", "Ruby", "Swift"]
languages.contains("Swift")

extension String {
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if self.contains(item) {
                return true
            }
        }

        return false
    }
}

input.containsAny(of: languages)

languages.contains(where: input.contains)


// MARK: attributed Strings:
    // Attributed strings are made up of two parts: a plain Swift string, plus a dictionary containing a series of attributes that describe how various segments of the string are formatted. In its most basic form you might want to create one set of attributes that affect the whole string, like this:

let string = "This is a test string"
let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.black,
    .backgroundColor: UIColor.cyan,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString = NSAttributedString(string: string, attributes: attributes)


// MARK: NSMutableAttributedString - attributed string that can be modified:

let attributedString2 = NSMutableAttributedString(string: string)
attributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))


// MARK: There are lots of formatting options for attributed strings, including:

// * Set .underlineStyle to a value from NSUnderlineStyle to strike out characters.
// * Set .strikethroughStyle to a value from NSUnderlineStyle (no, that’s not a typo) to strike out characters.
// * Set .paragraphStyle to an instance of NSMutableParagraphStyle to control text alignment and spacing.
// * Set .link to be a URL to make clickable links in your strings.
// And that’s just a subset of what you can do.

// You might be wondering how useful all this knowledge is, but here’s the important part: UILabel, UITextField, UITextView, UIButton, UINavigationBar, and more all support attributed strings just as well as regular strings. So, for a label you would just use attributedText rather than text, and UIKit takes care of the rest.

extension String {
    func addPrefix(prefix: String) -> String {
        guard !self.hasPrefix(prefix) else { return self }
        
        return String(prefix + self)
    }
}

var test = "vamos"

print(test.addPrefix(prefix: "va"))
