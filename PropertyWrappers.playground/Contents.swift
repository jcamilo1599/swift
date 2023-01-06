import UIKit

@propertyWrapper struct Capitalized {
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.capitalized }
    }

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}

struct User {
    @Capitalized var firstName: String
    @Capitalized var lastName: String
    
    func getName()->String {
        return firstName + " " + lastName
    }
}

let a = User(firstName: "juan", lastName: "marin")
print(a.getName())
