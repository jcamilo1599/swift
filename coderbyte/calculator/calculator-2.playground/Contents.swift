import Foundation

func Calculator(_ str: String) -> Int {
    func digit(_ d: Int) -> (Int, Int) -> Int {
        return { a, b in a * 10 + d }
    }
    
    func group(c: Int = 0, o: Int = 0) -> (Int, Int) -> Int { return { $0 * c + $1 * o } }
    
    let oper:[Character: (Int, Int) -> Int] = [
        "+": (+),
        "-": (-),
        "*": (*),
        "/": (/),
        "(":group(o:1), ")": group(c: 1),
        "=":group(),
        "!":group(o: -1),
        "0": digit(0),
        "1": digit(1),
        "2": digit(2),
        "3": digit(3),
        "4": digit(4),
        "5": digit(5),
        "6": digit(6),
        "7": digit(7),
        "8": digit(8),
        "9": digit(9)
    ]
    
    let priority : [Character: Int] = [
        "+": 1,
        "-": 1,
        "*": 2,
        "/": 2,
        "!": 3
    ]
    
    typealias OperValue = (symbol: Character, prio: Int, value: Int)
    
    func calcPrio(_ ovs: [OperValue], _ doPrio: Int) -> [OperValue] {
        func execute( _ stack: [OperValue], ov: (current: OperValue, next: OperValue)) -> [OperValue] {
            let previous = stack.last ?? ("=", ovs.first!.prio, 0)
            
            if ov.current.prio > doPrio && previous.prio == doPrio {
                return stack
            }
            
            if ov.current.prio != doPrio {
                return stack + [ov.current]
            }
            
            let value = oper[ov.current.symbol]!(previous.value, ov.next.value)
            
            return (previous.prio >= doPrio ? Array(stack.dropLast()) : stack ) + [(Character("="), doPrio, value)]
        }
        
        return zip(ovs, ovs.dropFirst() + [("=", doPrio, 0)]).reduce([OperValue](), execute)
    }
    
    func adjust(_ s:String, _ adjust: (Character, Character) -> [Character]) -> String {
        return String(zip([" "] + s, s).flatMap(adjust))
    }
    
    var formula = adjust(str) { $1 == "(" && "0123456789)".contains("\($0)") ? ["*","("] : [$1] }
    formula = adjust(formula) { "0123456789".contains("\($1)") && $0 == ")"  ? ["*",$1] : [$1] }
    formula = adjust(formula) { $1 == "-" && priority[$0] != nil ? ["!"] : [$1] }
    
    let openclose = formula.map{ $0 == "(" ? 10 : $0 == ")" ? -10 : 0 }
    let levels = openclose.reduce([0]){ $0 + [($0.last ?? 0) + $1] }
    let priorities = zip(levels, formula).map{ $0 + (priority[$1] ?? 4) }
    let operValues = zip(formula, priorities).map{($0, $1, 0) as OperValue}
    let results = Set(priorities).sorted(by:>).reduce(operValues, calcPrio)
    
    return results.first?.value ?? 0
}


print(Calculator("6*(4/2)+3*1"));
print(Calculator("6/3-1"));
