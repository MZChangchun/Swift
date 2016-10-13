//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/**
 *  扩展就是类目/类别(Extension)
 */
//与 Objective-C 不同的是,Swift 的扩展没有名字
//扩展可以对一个类型添加新的功能,但是不能重写已有的功能。
//extension SomeType{
//    //加入到sometype的新功能写到这里
//}
//extension SomeType: SomeProctocol,AnotherProctocol {
//    //协议实现写到这里
//}
//注意:如果你定义了一个扩展向一个已有类型添加新功能,那么这个新功能对该类型的所有已有实例中都是可用的,即使它们是在你的这个扩展的前面定义的。


/**
 *  计算属性
 */

extension Double {
    var km: Double {return self * 1_000.0}
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")


/**
 *  构造器
 */
struct Size {
    var width = 0.0, heigh = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, heigh: 5.0))
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.heigh / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)

    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, heigh: 3.0))



/**
 *  方法
 */
extension Int {
    //repetitions 方法使用了一个 () -> () 类型的单参数(single argument),表明函数没有参数而且没有返回值
    func repetitions(task: () ->()) {
        for _ in 0..<self {
            task()
        }
    }
}
3.repetitions({print("Hello!")})
3.repetitions{print("Goodbye!")}//可以使用 trailing 闭包使调用更加简洁:

//可变实例方法 mutating
extension Int {
//    结构体和枚举类型中修改 self 或其属性的方法必须将该实例方 法标注为 mutating
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()


/**
 *  下标 subscript
 */
extension Int {
    subscript(var digitIndex: Int) -> Int {
        var decimalBase = 1
        while digitIndex > 0 {
            decimalBase *= 10
            digitIndex -= 1
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
746381295[1]
746381295[9]



/**
 *  嵌套类型
 */
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}
func PrintIntegerKinds(numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
PrintIntegerKinds([3, 19, -27, 0, -6, 0, 7])


































































































