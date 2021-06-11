import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        
        var offset = 0
        var endIndex: String.Index
        var beginIndex: String.Index
        var multiplierString = ""
        var changeableMessage = message
        var subStringVar: String.SubSequence
        var stringForInsert = ""
        var multiplier = 0

        
        
        let numbers: [String.Element] = ["0" , "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8" , "9" ]
        
        while changeableMessage.contains("[") {
            offset = 0
      
            for char in changeableMessage {
                
                if char == "]" {
                    endIndex = changeableMessage.index(changeableMessage.startIndex, offsetBy: offset)
                    offset -= 1
                    subStringVar = changeableMessage[..<endIndex]
                    print("subStringVar with begining: \(subStringVar)")
                    for i in subStringVar.reversed() {
                        if i == "[" {
                            beginIndex = changeableMessage.index(changeableMessage.startIndex, offsetBy: offset + 1)
                            subStringVar = changeableMessage[beginIndex..<endIndex]
                            beginIndex = changeableMessage.index(changeableMessage.startIndex, offsetBy: offset)
                            print("subStringVar: \(subStringVar)")
                           
                            while offset > 0 && numbers.contains(changeableMessage[changeableMessage.index(changeableMessage.startIndex, offsetBy: offset - 1)])  {
                                offset -= 1
                                multiplierString = String(changeableMessage[changeableMessage.index(changeableMessage.startIndex, offsetBy: offset)]) + multiplierString
                            }
                            beginIndex = changeableMessage.index(changeableMessage.startIndex, offsetBy: offset)
                            
                            
                            print("multiplierString: \(multiplierString)")
                            if multiplierString == "" {
                                multiplier = 1
                            } else {
                                multiplier = Int(multiplierString) ?? 0
                            }
                            if multiplier > 0 {
                                for _ in 1...multiplier {
                                    stringForInsert.append(String(subStringVar))
                                }
                            }
                            multiplierString = ""
                            print("stringForInsert: \(stringForInsert)")
                            
                            changeableMessage.removeSubrange(beginIndex...endIndex)
                            
                            print("changableMessage after remove: \(changeableMessage)")
                            
                            changeableMessage.insert(contentsOf: stringForInsert, at: beginIndex)
                            stringForInsert = ""
                            
                            print("changableMessage after insert: \(changeableMessage)")

                            break
                        } else {
                            offset -= 1
                        }
                    }
                    break
                } else {
                    offset += 1
                }
            }
        }
        
        
        return changeableMessage
    }
}
