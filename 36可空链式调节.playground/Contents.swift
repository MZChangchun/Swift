//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/**
 *  可空链式调用 （optional Chaining）
 */
/**
    是一种可以请求和调用属性，方法以及下标的过程。她的可空性体现于请求或者调用的目标当前可能为空。如果可空的目标有值，那么调用就会成功；如果选择的目标为空，那么这种调用将返回空。
 
 多个连续调用可以被链接在一起形成一个调用链，如果其中任何一个节点为空，将导致整个调用链失败
 
 > 注意: Swift 的可空链式调用和 Objective-C 中的消息为空有些相像,但是 Swift 可以使用在任意类型 中,并且能够检查调用是否成功。
 */

class Person {
    var residence: Residence?
}
class Residence {
    var numberOfRooms = 1
}

let john = Person()//如果创建一个新的 Person 实例,因为它的 residence 属性是可空的, john 属性将初始化为 nil
//let roomCount = john.residence!.numberOfRooms//如果使用叹号(!)强制展开获得这个 john 的 residence 属性中的 numberOfRooms 值,会触发运行时错误

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms")
}

john.residence = Residence()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms")
}



class Person2 {
    var residence: Residence2?
}
class Residence2 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
    
}
class Room {
    let name: String
    init(name:String){self.name = name}
}
class Address{
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil {
            return buildingNumber
        } else {
            return nil
        }
    }
}

let john2 = Person2()
if let roomCount = john2.residence?.numberOfRooms {
    print("John2's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john2.residence?.address = someAddress
if john2.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
if (john2.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}
if let firstRoomName = john2.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
john2.residence?[0] = Room(name: "Bathroom")//这次赋值同样会失败,因为 residence 目前是 nil 。

let johnsHouse = Residence2()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john2.residence = johnsHouse
if let firstRoomName = john2.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

//访问可空类型的下标
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brain"]?[0] = 72
print(testScores)

if let johnsStreet = john2.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

let johnsAddress = Address()
johnsAddress.buildingNumber = "The Larches"
johnsAddress.street = "Larches Street"
john2.residence?.address = johnsAddress
if let johnsStreet = john2.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

if let buildingIdentifier = john2.residence?.address?.buildingIdentifier() {
    print("John2's building identifier is \(buildingIdentifier)")
}

if let beginsWithThe =
    john2.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    } }

























































































































































































