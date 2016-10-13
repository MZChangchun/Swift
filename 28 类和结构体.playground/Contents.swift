//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  类和结构体的对比
 */
/*共同点：

        定义属性用于存储值
        定义方法用于提供功能
        定义附属脚本用语访问值
        定义构造器用于生成初始化值
        通过扩展以增加默认实现的功能
        实现协议以提供某种标准功能
 
与结构体相比，类还有如下的附加功能
         继承允许一个类继承另一个类的特征
         类型转换允许在运行时检查和解释一个类实例的类型
         解构器允许一个类实例释放任何其所被分配的资源
         引用计数允许对一个类的多次引用
*/
class SomeClass {
    //类
}
struct SomeStructure {
    //结构体
}

struct Resolution {
    var width      = 0
    var height     = 0
}
class VideoMode {
    var resoultion = Resolution()//分辨率
    var interlaced = false
    var frameRate  = 0.0
    var name: String?
}
let someResolution = Resolution()
let someVideoMode = VideoMode()
print("The width of someResolution is \(someResolution.width)")
someVideoMode.resoultion.width = 1280//与 Objective-C 语言不同的是,Swift 允许直接设置结构体属性的子属性

//构造器
let vga = Resolution(width: 640, height: 480)

/**
 *  结构体和枚举是值类型(＝代表拷贝的是值)
 */
//结构体
var cinema = vga //深拷贝
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("vga is still \(vga.width) pixels wide")

//枚举
enum CompassPoint {
    case North, South, East, West
}
var currentDirecton = CompassPoint.West
let rememberedDirection = currentDirecton
currentDirecton = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West!")
}

/**
 *  类是引用类型 （=代表拷贝地址）
 */
let tenEughty = VideoMode()
tenEughty.resoultion = vga
tenEughty.interlaced = true
tenEughty.name = "1080"
tenEughty.frameRate = 25.0

let alsoTenEighty = tenEughty
alsoTenEighty.frameRate = 30.0
print("The frameRate property of tenEighty is now \(tenEughty.frameRate)")

/**
 *  恒等运算符 === !==
 */
//等价于”(用三个等号表示, === )
//等价于”表示两个类类型(class type)的常量或者变量引用同一个类实例

if tenEughty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same Resolution instance")
}


/**
 *  结构体和类的选择
 结构体实例总是通过值传递,类实例总是通过引用传递
 */
/*
 选择结构体：
         该数据结构的主要目的是用来封装少量相关简单数据值
         有理由预计该数据结构的实力在被赋值或传递时，封装的数据将会被拷贝而不是被引用
         该数据结构中储存的值类型属性，也应该被拷贝而不是被引用
         该数据皆哦股不需要去继承另外一个既有类型的属性活着行为
 例子：
         几何体形状的大小，封装一个width属性和height属性，两者均为double类型
         一定范围内的路径，封装一个start属性和length属性，两者均为Int类型
         三位坐标系内一点，封装x, y, z属性，三者均为Double类型
 */



//注意，在swift中，诸如String，Array，Dictionary 类型均是结构体，这意味着被赋值给新的常量或者变量，或者被传入函数或方法中时，他们的值会被拷贝。
//然而在Object－C中，NSString, NSArray, NSDictionary类型均是以类的形式实现，而非结构体

//以上是对字符串、数组、字典的“拷贝”行为的描述。在你的代码中,拷贝行为看起来似乎总会发生。然而,Sw ift 在幕后只在绝对必要时才执行实际的拷贝。Swift 管理所有的值拷贝以确保性能最优化,所以你没必要去回 避赋值来保证性能最优化。













































































































