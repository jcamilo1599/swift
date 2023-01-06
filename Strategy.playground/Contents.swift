import UIKit

protocol Log {
    func write(_ message: String)
}

struct ConsoleLog: Log {
    func write(_ message: String) {
        print(message)
    }
}

struct DBLog: Log {
    func write(_ message: String) {
        print("Save in DB: " + message)
    }
}


struct Test {
    let log: Log
    
    func run() {
        log.write("MENSAJE")
    }
}

var a = Test(log: ConsoleLog())
a.run()
