//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  属性
 */
//属性 将值跟特定的类，结构体或枚举关联。存储属性
//计算属性    计算一个值                    可以用于类，结构体，枚举
//存储属性    存储变量或常量作为实例的一部分   只能用于类和结构体
//属性观察器   监控属性值的变化触发一个操作    自己定义的存储属性上，也可以添加到从父类继承的属性上





/**
 *  存储属性
 */
struct FixedLengthRange {
    var firstValue: Int
    let length:Int//(创建后无法修改的属性)
}
var rangOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangOfThreeItems.firstValue = 6

let rangOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangOfFourItems.firstValue = 6//（错误）结构体属于值类型，值类型被声明为常量后，他的所有属性也都成了常量
//引用类型则不一样，把一个引用类型的实例赋值给一个常量后，仍然可以修改该实例的变量属性



//延迟存储属性(必须是var) 前缀 lazy
//当属性的值依赖于在实例的构造过程结束后才会知道具体值的外部因素时,或者当获得属性的初始值需要复杂或大量计算时,可以只在需要的时候计算它
class DataImporter {
    /// 这是一个将外部文件中的数据导入的类，这个类的初始化会消耗不少时间
    var fileName = "data.txt"
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("some more data")//此时,manage的importer属性还没有被创建
print(manager.importer.fileName) //importer属性只有在第一次被访问的时候才被创建
//如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问,则无法保证该属性只会被初始化一次。
//OC中的属性都有对应的实例变量_ swift中的属性没有对应的实例变量







/**
 *  计算属性（必须var）
 */
//计算属性不直接存储值，而是提供一个getter和一个（可选的）setter

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center : Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y:centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at \(square.origin.x), \(square.origin.y)")

//（便捷setter声明）计算属性的setter没有定义表示新值的参数，则可以使用newValue
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y:centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }

    }
}

//只读属性（只有getter没有setter）
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volum: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print(fourByFiveByTwo.volum)






/**
 *  属性观察器  不能用于延迟存储属性（每次属性被设置的时候都会调用属性观察器，甚至新的值和现在的值相同也不例外）
 */
// willSet 在新值被设置之前调用
//didSet 在新值被设置之后立即调用
//父类的属性在子类的构造器中被赋值时，他在父类中的willSet和didSeta观察器会被调用

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 300
stepCounter.totalSteps = 100
stepCounter.totalSteps = 500





/**
 *  全局变量(常量)和局部变量(常量)
 */
/*
 全局变量(常量)    延迟计算，不需要标记lazy特性   在函数，方法，闭包或任何类型之外定义的
 局部变量(常量)    非延迟计算                   在函数，方法，闭包或任何类型内部定义的
 */



/**
 *  类型属性(可以看作是类的属性)
 */

struct SomeStructure {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 27
    }
    class var voerrideableComputedTypeProperty: Int {
        return 107
    }
}
//类型属性是通过类型本身来获取和设置,而不是通过实例
print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value"
print(SomeStructure.storedTypeProperty)
print(SomeEnumeration.computedTypeProperty)
print(SomeClass.computedTypeProperty)

//左右声道
struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                //将新电平值设置为阀值
                currentLevel = AudioChannel.thresholdLevel//didSet 属性观察器将 currentLevel 设置成了不同的值,但这时不会再次调用属性观察 器
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                //存储当前电平值作为最大输入电平
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)









































































































