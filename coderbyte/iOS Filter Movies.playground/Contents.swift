import UIKit
import Foundation

struct UserModel: Hashable, Encodable {
    var name = ""
    var username = ""
    var email = ""
}

func plain(_ items: [UserModel]) -> String {
    let encoded = try! JSONEncoder().encode(items)
    var text = String(bytes: encoded, encoding: .utf8)!;
    text = text.replacingOccurrences(of: "\":\"", with: "=")
    text = text.replacingOccurrences(of: "\",\"", with: ", ")
    text = text.replacingOccurrences(of: "\"},{\"", with: "; ")
    text = text.replacingOccurrences(of: "[{\"", with: "")
    text = text.replacingOccurrences(of: "\"}]", with: ";")
    
    return text
}

func removeDuplicate(_ str: String) -> String {
    let arr = str.components(separatedBy: "; ")
    var items: Set<UserModel> = []
    
    for a in arr {
        let itemList = a.components(separatedBy: ", ")
        var item: UserModel = UserModel()
        var insertItem = true
        
        for b in itemList {
            let subItem = b.components(separatedBy: "=")
            
            if (subItem[0] == "name") {
                item.name = subItem[1]
            }
            
            if (subItem[0] == "username") {
                item.username = subItem[1]
            }
            
            if (subItem[0] == "email") {
                item.email = subItem[1]
            }
        }
        
        for c in items {
            if c.username == item.username {
                insertItem = false
            }
        }
        
        if insertItem {
            items.insert(item)
        }
    }
    
    return plain(Array(items))
}

let data = "name=Dan B, username=db, email=db@gmail.com, id=123; name=Hannah, username=hsmith, id=333, email=hsm@test.com; name=Dan Brick, username=db, email=db@gmail.com, id=663;"

return removeDuplicate(data)

}
