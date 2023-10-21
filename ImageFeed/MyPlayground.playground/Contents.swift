import UIKit

struct User {                   // 1
    var name: String            // 2
    var id: Int?                // 3
    
    mutating func makeId() {    // 4
        id = name.hashValue     // 5
    }
}

var person = User(name: "f", id: 8)   // 6
person.id = 9
print(person.id)
// 8
