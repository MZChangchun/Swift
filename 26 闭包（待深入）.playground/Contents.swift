//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  闭包（block）
闭包是自包含函数的代码块，可以在代码中被传递和使用。
 闭包可以捕获和存储其所在上下文任意常量和变量的饮用。
 
 全局函数是一个有名字但不会捕获任何值的闭包
 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
 闭包表达式是一个利用轻量级语法所写的可以捕获上下文中变量或常量值的匿名闭包
 */
//闭包形式
//    { (parameters) -> returnType in
//        statements
//}

//sort 的方法,会根据您提供的用于排序的闭包函数将已知类型数组中的值进行排序。一 旦排序完成, sort(_:) 方法会返回一个与原数组大小相同,包含同类型元素且元素已正确排序的新数组。原数组 不会被 sort(_:) 方法修改。

let names = ["chria", "Alex", "Ewa", "Barry", "Daniella"]
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversed = names.sort(backwards)
//相当于一下闭包
reversed = names.sort({ (s1: String, s2: String) ->Bool in
    return s1 < s2
})
print(reversed)

reversed = names.sort({s1, s2 in return s1 > s2})
print(reversed)

//单表达式隐式返回
reversed = names.sort({ s1, s2 in s1 < s2 })
print(reversed)

//参数名名称缩写
reversed = names.sort({$0 > $1}) //Swift 自动为内联闭包提供了参数名称缩写功能,您可以直接通过 $0 , $1 , $2 来顺序调用闭包的参数,以此 类推。
print(reversed)

//运算符函数
reversed = names.sort(<)
print(reversed)

/**
 *  尾随闭包
 */
//func someFunctionThatTakesACLosure(closure: () ->void) {
//    //函数体部分
//}
//someFunctionThatTakesACLosure({
//    //闭包主体部分
//})
////以下使用尾随闭包进行函数调用
//someFunctionThatTakesACLosure(){
//    //闭包主题部分
//}
//例如：
reversed = names.sort({$0 > $1})
reversed = names.sort(){ $0 > $1}
reversed = names.sort { $0 > $1 }//函数只需要闭包表达式一个参数,当您使用尾随闭包时,您甚至可以把 () 省略掉

let digitNames = [ 0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
                   5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map {//其获取一个闭包表达式作为其唯一参数。该闭包函数会为数组中的每一个元素调用一次,并返回该元素所映射的值。
    (var number) -> String in
    var output = ""
    while number > 0 {
     output = digitNames[number % 10]! + output
    number /= 10
    }
    return output
}
print(strings)

//捕获值
func makeIncrementor(forIncrement amount: Int) ->() ->Int {
    var runningTotal = 0
    func incrementor()->Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}
//闭包是引用类型
//无论您将函数或闭包赋值给一个常量还是变量,您实际上都是将常量或变量的值设置为对应函数或闭包的引 用
let increamentByTen = makeIncrementor(forIncrement: 10)//为什么不变呢？其实这是因为incrementByTen = incrementor
increamentByTen()
increamentByTen()
increamentByTen()
let incrmenteBySeven = makeIncrementor(forIncrement: 7)
incrmenteBySeven()
incrmenteBySeven()
incrmenteBySeven()
increamentByTen()

/**
 *  非逃逸闭包
 */
//当一个闭包作为参数传到一个函数中,但是这个闭包在函数返回之后才被执行,我们称该闭包从函数中逃逸。
//当定义接收闭包作为参数的函数时，可以在参数名之前标注@noescape，用来指明这个闭包不允许逃逸出这个函数
func someFunctionWithNoescapeClosure(@noescape closure: () -> Void) {
    closure()
}
//该闭包被添加到一个函数外定义的数组 中。如果你试图将这个参数标注为 @noescape ,你将会获得一个编译错误
var completionHandlers:[() ->Void] = []
func someFunctionWithEscapingClosure(completionHandler: () -> Void) {
    completionHandlers.append(completionHandler)
}

//将闭包标注为 @noescape 使你能在闭包中隐式地引用 self 。
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure{self.x = 100}
        someFunctionWithNoescapeClosure{x = 200}
    }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x)
completionHandlers.first?()
print(instance.x)

//自动闭包，代码延迟直到调用，相当于block里面的代码
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

// customerProvider 的类型不是 String ,而是 () -> String ,一个没有参数且返回值为 String 的函数。
let customerProvidler = {customersInLine.removeAtIndex(0)}
print(customersInLine.count)

print("Now serving \(customerProvidler())!")
print(customersInLine.count)

//将闭包作为参数传递给函数时,你能获得同样的延时求值行为
func serveCustomer(customerProvider:()->String) {
    print("Now serving \(customerProvider())")
}
serveCustomer({customersInLine.removeAtIndex(0)})

func serveCustomer(@autoclosure customerProvider:()->String) {
    print("Now serving \(customerProvider())")
}
serveCustomer(customersInLine.removeAtIndex(0))
//@autoclosure 特性暗含了 @noescape 特性,这个特性在非逃逸闭包 (页 0)一节中有描述。如果你想让这个闭包 可以“逃逸”,则应该使用 @autoclosure(escaping) 特性.
// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(@autoclosure(escaping) customerProvider: () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.removeAtIndex(0))
collectCustomerProviders(customersInLine.removeAtIndex(0))
print("Collected \(customerProviders.count) closures.")
// prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// prints "Now serving Barry!"
// prints "Now serving Daniella!"






























