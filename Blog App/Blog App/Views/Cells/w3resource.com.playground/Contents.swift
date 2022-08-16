import UIKit


func returningEvenIndices(_ str: String) -> String {
    if str.isEmpty { return ""}
    var newStr = ""
    
    for (i,k)in str.enumerated() {
        if i % 2 == 0 {
            newStr.append(k)
        }
   
    }
    return newStr
}

returningEvenIndices("WELCOMzE")
