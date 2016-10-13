//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  方法
 */
//结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一
/*
实例方法 :为给定类型的实例封装 了具体的任务与功能     类、结构体、枚举都可以定义实例方法
类型方法 :类型方法与类型本身相关联,相当于类方法(OC)   类、结构体、枚举也可以定义类型方法
*/

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func incrementBy(amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter()
counter.increment()
counter.count
counter.incrementBy(5)
counter.count
counter.reset()
counter.count

class Counter2 {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}
let counter2 = Counter2()
counter2.incrementBy(5, numberOfTimes: 3)
counter2.count

//使用self消除x歧义
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    print("This point is to the right of the line where x == 1.0")
}



//在实例方法中修改值类型 （变异（mutating））
//结构体和枚举是值类型。一般情况下,值类型的属性不能在它的实例方法中被修改
struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var somePoint2 = Point2(x: 1.0, y: 1.0)
somePoint2.moveByX(2.0, y: 3.0)
print("The point is now at (\(somePoint2.x), \(somePoint2.y))")
//不能在结构体类型常量上调用可变方法,因为常量的属性不能被改变,即使想改变的是常量的变量属性也 不行
//结构体和枚举是值类型，所以不能在常量中修改属性，也就不能使用了
let fixedPoint = Point2(x: 3.0, y: 3.0)
//fixedPoint.moveByX(2.0, y: 3.0)//错误


//在可变方法中给self赋值
struct Point3 {
    var x = 0.0, y = 0.0
    mutating func moveByX (deltaX: Double, y deltaY: Double) {
        self = Point3 (x: x + deltaX, y: y + deltaY)
    }
}

//枚举的可变方法可以吧self设置为相同的枚举类型中不同的成员
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()



//未完成理解片面

/**
 *  类型方法
 */
class SomeClass {
    static func someTypeMethod() {
        //
    }
}
SomeClass.someTypeMethod()

struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel{
            highestUnlockedLevel = level
        }
    }
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.completedLevel(5)
print("Highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "beto")
if player.tracker.advanceToLevel(8) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}

var player2 = Player(name: "beto")
if player2.tracker.advanceToLevel(6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}

























































































































































































