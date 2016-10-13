//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/**
 *  枚举
 */
enum CompassPoint {
    case North
    case South
    case East
    case West
}
enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
//一旦 directionToHead 被声明为CompassPoint 类型,你可以使用更短的点语法将其设置为另一个 CompassPoint 的值
var directionToHead = CompassPoint.West
directionToHead = .East

directionToHead = .South
switch directionToHead {
case .North:
    print("Lots of palnets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rises")
case .West:
    print("Where the skies are blue")
}
//在判断一个枚举类型的值时, switch 语句必须穷举所有情况。如 果忽略了 .West 这种情况,上面那段代码将无法通过编译,因为它没有考虑到 CompassPoint 的全部成员。强制穷 举确保了枚举成员不会被意外遗漏

//当不需要匹配每个枚举成员时，使用default分支来涵盖所有的未明确处理的枚举成员
let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for hunans")
}

//关联值
enum Barcode {
    case UPCA(Int, Int ,Int, Int)
    case QRCode(String)
}
var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode):
    print("QR code: \(productCode).")
}

//如果一个枚举成员的所有关联值都被提取为常量,或者都被提取为变量,为了简洁,你可以只在成员名称前标注 一个 或者 :
switch productBarcode {
case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .QRCode(productCode):
    print("QR code: \(productCode).")
}

//原始值
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

//原始值的隐式赋值
enum Plant: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
print(Plant.Mars.rawValue)
enum CompassPoints: String {
    case North, South, East, West
}
print(CompassPoints.North.rawValue)

//使用原始值初始化枚举实例
let possiblePlanet = Plant(rawValue: 7)//  是可选的类型,或者说“可选的，有可能为nil

let positionToFind = 9
if let somePlanet = Plant(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't planet at position \(positionToFind)")
}

/**
 *  递归枚举
 */
//递归枚举是一种枚举类型，他有一个或者多个枚举成员使用该枚举类型的实例作为关联值，可以在枚举成员前加上indirect表示可递归
enum ArithmeticExpression {
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}
//所有成员都是递归
//indirect enum ArithmeticExpression {
//    case Number(Int)
//    case Addition(ArithmeticExpression, ArithmeticExpression)
//    case Multiplication(ArithmeticExpression, ArithmeticExpression)
//}

func evaluate(expression: ArithmeticExpression) -> Int {
    switch expression {
    case .Number(let value):
        return value
    case .Addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .Multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}
//计算（5 ＋ 4） ＊ 3
let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
print(evaluate(product))








































