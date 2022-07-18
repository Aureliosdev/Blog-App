import UIKit

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
