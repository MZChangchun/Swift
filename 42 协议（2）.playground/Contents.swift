//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/**
 *  类专属协议
 */
//可以在协议的继承列表中，通过添加class关键字，限制协议职能适配到类类型
//protocol SomeClassOnlyProtocol: class, someInheritedProtocol {
//    //协议定义
//}




/**
 *  协议合成
 */
protocol Named {
    var name: String{get}
}
protocol Aged {
    var age: Int {get}
}
struct Person: Named, Aged {
    var name: String
    var age: Int
}
//协议合成 并不会生成一个新协议类型,而是将多个协议合成为一个临时的协议,超出范围后立即失效。
func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}
let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)


/**
 *  检验协议的一致性
 */
//is 检查实例是否遵循了某个协议
//as? 遵循协议返回协议类型，否则返回nil
//as 强制向下转型，如果失败会产生运行时错误
protocol HasArea {
    var area: Double {get}
}
class Circle: HasArea {
    let pi = 3.1415926
    var radius: Double
    var area: Double {return pi * radius * radius}
    init(radius: Double){self.radius = radius}
}
class Country: HasArea {
    var area: Double
    init(area: Double) {self.area = area}
}
class Animal {
    var legs: Int
    init(legs: Int) {self.legs = legs}
}
let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]
for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}


/**
 *  对可选协议的规定（optional）
 */
//协议可以含有可选成员。遵循着可以选择是否实现这些成员。当需要使用可选规定的方法或者属性时，他的类型自动变成可选的。（ (Int) -> String  会变成 ((Int) -> String)? ）整个函数定义包裹在可选中,而不是放在函数的返回值后 面
//可选协议只能在含有 @objc 前缀的协议中生效。

//严格来讲, 中的属性和方法都是可选的,因此可以在类中声明都不实现这些成员,尽管技术 上允许这样做,不过最好不要这样写。
@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int {get}
}
class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increament() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}
class ThreeSource:NSObject, CounterDataSource {
    let fixedIncrement = 3
}
var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increament()
    print(counter.count)
}

@objc class TowardsZeroSource:NSObject, CounterDataSource {
     func incrementForCount(count: Int) -> Int {
        if 0 == count {
            return 0
        } else if 0 > count {
            return 1
        } else {
            return -1
        }
    }
}
counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increament()
    print(counter.count)
}


/**
 *  协议扩展
 */

//使用扩展协议的方式可以为遵循协议者提供方法或者属性的实现。通过这样可以让你无需再每个遵循者中都实现一次，无需使用全局函数
protocol RandomNumberGenerator {
    func random() -> Double
}
//线性同余生成器(linear congruential generator)的伪随机数算法
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}



extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number:\(generator.random())")
print("And here's a random Booleam:\(generator.randomBool())")




/**
 *  提供默认实现
 */
//可以通过协议扩展的方式来为协议规定的属性和方法提供默认的实现，如果协议的遵循者对规定的属性和方法提供了自己的实现，那么遵循者提供的实现将被使用。
//通过扩展协议提供的协议实现和可选协议规定有区别。虽然协议遵循者无需自己实现,通过扩展提供的默认实现,可以不是用可选链调用。
protocol TextRepersentable {
    var textualDescription: String{get}
}
protocol PrettyTextRePresentable: TextRepersentable {
    var prettyTextualDescription: String {get}
}
extension PrettyTextRePresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}



/**
 *  为扩展协议添加限制条件 where
 */
//在扩展协议的时候，可以指定一些限制，只有满足这些限制的协议遵循者才能获得扩展提供的属性和方法。
extension CollectionType where Iterator.E: TextRepersentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joinWithSeparator(",") + "]"
    }
}
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
print(hamsters.textualDescription)











































































































































































































