import UIKit
import Foundation

func TwoInts( num1: Int, num2: Int) -> Bool {
    if num1 >= 0 && num2 <= 0 {
        return true
    }
    
    else if num1 <= 0 && num2 <= 0 {
        return true
    }
    else if num1 <= 0 && num2 <= 0 {
        return true
    }
    else {
        return false
    }
    
}

func makeStringIs(defaultString: String) -> String {
    let myIs = "Is"
    if defaultString.starts(with: myIs) {
        return defaultString
    }else if defaultString.contains(myIs) {
        return defaultString
    }else  {
        
        return myIs + defaultString
    }
    
}
print(makeStringIs(defaultString: "..."))


func removeChar(str1: String, n1: Int) -> String {
    if str1.isEmpty { return str1 }
    var newStr = str1
 
    newStr.remove(at: newStr.index(str1.startIndex, offsetBy: n1,limitedBy: newStr.endIndex)!)
        
    return newStr
    
}
print(removeChar(str1: "Hello", n1: 3))
 

func ReplaceChar(char: String) -> String {
    if char.isEmpty { return ""}
    var newChar = char
    let last = newChar.remove(at: newChar.startIndex)
    let first = newChar.remove(at: newChar.index(before: newChar.endIndex))
    
    newChar.append(last)
    newChar.insert(first, at: newChar.startIndex)
    return newChar
}
ReplaceChar(char: "MOTHER")

func multipleOf(num1: Int) -> Bool {
    
    if num1.isMultiple(of: 3) {
        return true
    }
//    else if num2.isMultiple(of: 5) {
//        return true
//    }
    return false
}
multipleOf(num1: 9)

func multipleOf2(num1: Int) -> Bool {
    if num1 % 3 == 0 || num1 % 5 == 0 {
        return true
    }
    
return false
    
}

multipleOf2(num1: 55)

func returniNgIs(str1: String) -> Bool {
    if str1.hasPrefix("Is") {
        return true
    }
    return false
    
}
returniNgIs(str1: "Is smail")
returniNgIs(str1: "ismaga")


func removeLastChar(_ string1: String) -> String {
    
    var newString = string1
    let newChar = newString.removeLast()
    let newStr = String(newChar)
    
    return newStr + string1 + newStr
}
removeLastChar("Hello")
let contact =
    ["address":
        [
            "zipcode": "12345",
            "street": "broadway",
            "city": "wichita"
]
]
func capitalizedAndTrimmed(_ string: String) -> String {
    return string.trimmingCharacters(in: .whitespaces).capitalized
}

var capitalizedStreet: String? = nil
var capitalizedCity: String? = nil
if let address = contact["address"] {
    if let street = address["street"] {
        capitalizedStreet = capitalizedAndTrimmed(street.capitalized)
    }
    if let city = address["city"] {
        capitalizedCity = capitalizedAndTrimmed(city.capitalized)
    }
}

