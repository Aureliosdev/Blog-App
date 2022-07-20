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
 
