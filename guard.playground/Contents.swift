import UIKit

class User {
    let name: String?
    
    init(_ name: String? = nil) {
        self.name = name
    }
}

let iUser = User("juan")

func test(){
    guard let name = iUser.name else {
        print("else")
        return
    }
    
    print(name)
}

test()
