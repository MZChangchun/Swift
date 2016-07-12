//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//函数的参数默认是常量

//func <#name#>(<#parameters#>) -> <#return type#> {
//    <#function body#>
//}
/**
 简单的一参一返回函数
 */
func sayHelloAgain(personName: String) ->String {
    let greeting = "Hello, " + personName + " !"
    return greeting
}

sayHelloAgain("Bao li jin")

/**
 *  无参一返回值函数
 */
func sayHelloWorld() -> String {
    return "Hello, world !"
}

func sayHello(personName: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return sayHelloAgain(personName)
    } else {
        return sayHelloWorld()
    }
}
sayHello("dsdsadas", alreadyGreeted: true)//当调用超过一个参数的函数时,第一个参数后的参数根据其对应的参数名称标记


/**
 *  无返回值函数
 严格意义上来来说，无返回值函数依然返回了值，返回的是一个特殊值void 他是一个空的元组 可以写成（）
 */
func sayGoodbye(personName: String) {
    print("Goodbye, \(personName)")
}
sayGoodbye("Wang jiao long")


/**
 *  多返回值函数（使用元组tuple）
 */
func minMax(array:[Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    
    for  value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value;
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
let array: [Int] = [0, 10, 11, 20, 30, -20]
minMax(array)
print("Min is \(minMax(array).min). and the max is \(minMax(array).max)")


/**
 *  当函数返回的元组类型有可能真个元组都没有之，使用可选元组（Optingal）
 
 注意
 可选元组类型如 (Int, Int)? 与元组包含可选类型如 (Int?, Int?) 是不同的.可选的元组类型,整个元组是可选 的,而不只是元组中的每个元素值。
 */
//如果传入的是一个空数组的话，上一个函数在访问array[0]的时候就会出问题
func minMaxNew(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty {return nil}
    var currentMin = array[0]
    var currentMax = array[0]
    
    for  value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value;
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
//这是，可以使用可选绑定来检查返回值
if let bounds = minMaxNew(array) {
    print("min is \(bounds.min) and the max is \(bounds.max)")
}

/**
 *  函数的参数名称
 函数都有一个外部函数名和一个局部参数名，局部参数名在函数的实现内部使用
 扯淡，函数名就是所谓的外部参数名，参数就是所谓的局部参数
 */
func someFunction(fistParameterName: Int, secondParameterName: Int) {
    //function body gose here
    //firstParamterName and secondParameterName refer to
    //the argument values for the first and second parameters
}
someFunction(1, secondParameterName: 2)

/**
 *  制定局部参数名对应的外部参数名，中间用空格分割
 */
func sayHelloSS(to person: String, and anotherPerson: String) -> String {
    return "Hello \(person) and \(anotherPerson)"
}
sayHelloSS(to: "Bao li jin", and: "wang jiao long")

/**
 *  忽略外部参数名
 */
func someFunctionNoName(firstParameterName: Int, _ secondParameterName: Int) {
    
}
someFunctionNoName(1, 2)

/**
 *  默认参数值
 */
func someFunctionDefault(parameterWithDefault: Int = 12) {
    print(parameterWithDefault)
}
someFunctionDefault()
someFunctionDefault(90)

/**
 *  可变参数
 一个函数最多只能有一个可变参数。
 如果函数有一个或多个带默认值的参数,而且还有一个可变参数,那么把可变参数放在参数表的最后。
 可以接受零个或多个值
 */
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(3, 8.25, 18.75)

/**
 *  变量参数
 函数的参数默认是常量
 */
func alignRight(var string: String, totalLength: Int, pad: Character) -> String {
    let amountToPad = totalLength - string.characters.count
    if amountToPad < 1 {
        return string
    }
    let padString = String(pad)
    for _ in 1...amountToPad {
        string = padString + string
    }
    return string
}
let originalString = "hello"
let paddedString = alignRight(originalString, totalLength: 10, pad: "-")


/**
 *  输入输出参数
 变量参数，只能修改到函数内部，使用输入输出参数就能在函数内部修改外部变量
 */
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var first = 20
var second = 30
swapTwoInts(&first, &second)
print("20 - \(first) and 30 - \(second)")

/**
 *  使用函数类型
 */
func addTwoInts(a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunction: (Int, Int) ->Int = addTwoInts  //定义一个类型为函数的常量或变量
let anotherMathFunction = addTwoInts //或者让swift自己判断类型也是可以的


mathFunction(2, 3)
mathFunction = multiplyTwoInts
mathFunction(2, 3)


/**
 *  嵌套函数（）
 一个外围函数也可以返回他的某一个嵌套函数，使得这个函数可以在其他域中被使用
 */
func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    func stepForward(input :Int) ->Int {
        return input + 1
    }
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    return backwards ? stepBackward : stepForward
}

var currentValue = -4
let moveNearerToZero = chooseStepFunction(currentValue > 0)
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}




