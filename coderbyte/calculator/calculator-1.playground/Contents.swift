import Foundation

func calc(currentOperator: String, currentValue: Int, newValue: Int) -> Int {
    var resp = currentValue
    
    if currentOperator == "*" {
        resp *= newValue
    } else if currentOperator == "/" {
        resp /= newValue
    } else if currentOperator == "-" {
        resp -= newValue
    } else {
        resp += newValue
    }
    
    return resp
}

func Calculator(_ str: String) -> String {
    let operators = ["+", "-", "/", "*"]
    var searchNumber: [String] = []
    var searchOperator: [String] = []
    var currentNumber = ""
    
    for (index, char) in str.enumerated() {
        let isOperator = operators.filter { a in
            return String(a) == String(char)
        }
        
        if isOperator.count > 0 {
            searchNumber.append(currentNumber)
            searchOperator.append(isOperator[0])
            currentNumber = ""
        } else {
            currentNumber = currentNumber + String(char)
            
            if index == (str.count - 1) {
                searchNumber.append(currentNumber)
            }
        }
    }
    
    var isParenthesis = false
    var searchNumberParenthesis: [String] = []
    var respParenthesis = 0
    var resp = 0
    
    for (_, char) in searchNumber.enumerated() {
        if String(char).contains("(") {
            isParenthesis = true
            
            let cleanNumber = char.replacingOccurrences(of: "(", with: "")
            searchNumberParenthesis.append(cleanNumber)
        } else if isParenthesis {
            if String(char).contains(")") {
                let cleanNumber = char.replacingOccurrences(of: ")", with: "")
                searchNumberParenthesis.append(cleanNumber)
                
                for (_, charParenthesis) in searchNumberParenthesis.enumerated() {
                    if respParenthesis == 0 {
                        respParenthesis = Int(charParenthesis)!
                    } else {
                        respParenthesis = calc(
                            currentOperator: searchOperator[1],
                            currentValue: respParenthesis,
                            newValue: Int(charParenthesis)!
                        )
                        
                        searchOperator.remove(at: 1)
                    }
                }
                
                resp = calc(
                    currentOperator: searchOperator[0],
                    currentValue: resp,
                    newValue: respParenthesis
                )
                
                searchOperator.remove(at: 0)
                
                isParenthesis = false
                searchNumberParenthesis = []
                respParenthesis = 0
            } else {
                searchNumberParenthesis.append(char)
            }
        } else if resp == 0 {
            resp = Int(char)!
        } else {
            resp = calc(
                currentOperator: searchOperator[0],
                currentValue: resp,
                newValue: Int(char)!
            )
            
            searchOperator.remove(at: 0)
        }
    }
    
    return String(resp)
}

print(Calculator("6*(4/2)+3*1"));
print(Calculator("6/3-1"));
