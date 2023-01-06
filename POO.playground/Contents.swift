import UIKit

protocol Pet {
    var name: String {get set}
    func makeNoise()
    func eat()
}

protocol Runner {
    func run()
}

protocol Flyer {
    func fly()
}

class Test {
    public func test_1() {
        print("Run test")
    }
    
    internal func test_2() {
        print("Run test")
    }
    
    private func test_3() {
        print("Run test")
    }
}

class Test2 {
    func test2_1() {
        print("Run test")
    }
}

final class Dog: Pet, Runner {
    func run() {
        print("Runing")
    }
    
    var name: String = "Perro"
    
    func makeNoise() {
        print("Dog make noise")
    }
    
    func eat() {
        print("Dog eat")
    }
}
