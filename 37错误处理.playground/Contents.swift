//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  错误处理 （Error Handling）
 */
/**
     错误处理，是响应错误以及从错误中恢复的过程。swift提供了在运行对可恢复错误的抛出，捕获，传送和操作的高级支持
     
     某些操作并不能总是保证执行所有代码都可以执行或总会产出有用的结果。可选类型涌来表示值可能为空，但是当执行失败的时候，通常要去了解此次失败是由何引起，你的代码就能做出与之相应的反应。
     
     举个例子，假如有个从磁盘上的某个文件读取以并做数据处理的任务，该任务会有多种可能失败的情形，包括指定路径下文件并不存在，文件不具有可读权限，或者文件编码格式不兼容。区分这些错误情形可以让程序解决并处理一部分错误，然后把它解决不了的错误报告给用户
     
     注意：swift中的错误处理涉及到错误处理模式，这回用到cocoa和oc中的NSError
 
 */

//11111111111111 swift中，错误用遵循ErrorType协议类型的值来表示
enum VendingMachineError: ErrorType {
    case InvalidSelection //选择无效
    case InsufficientFunds(coinsNeeden: Int) //金额不足
    case OutOfStock //缺货
}

//222222222222222 抛出错误使用throws关键字
throw VendingMachineError.InsufficientFunds(coinsNeeden: 5)

//333333333333333 处理错误
/*
             1.把函数抛出的错误传递给调用此函数的代码
             2.用do-catch语句处理错误
             3.将错误作为可选类型处理
             4.断言此错误根本不会发生
 */

//1.用throwing函数传递错误
//func canThrowErrors() throws -> String//只有throwing函数可以传递错误。任何在某个非throwing函数内部抛出的错误只能在此函数内部处理
//
//func cannotThrowErrors() -> String

struct Item {
    var price: Int
    var count: Int
}
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    func vend(itemNamed name: String) throws {
        guard var item = inventory[name] else {throw VendingMachineError.InvalidSelection}
        guard item.count > 0 else {throw VendingMachineError.OutOfStock}
        guard item.price <= coinsDeposited else {throw VendingMachineError.InsufficientFunds(coinsNeeden: item.price - coinsDeposited)}
        coinsDeposited -= item.price
        item.count -= 1
        inventory[name] = item
        dispenseSnack(name)
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels"
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName) //因为 vend(itemNamed:) 方法能抛出错误,所以在调用的它时候在它前面加了 try 关键字
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8

do {
    try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.InvalidSelection {
    print("Invalid Selection")
} catch VendingMachineError.OutOfStock {
    print("Out of Stock")
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}

print("dsadasdasdas")

//func someThrowingFunction() throws -> Int {
//    //...
//}
//let x = try? someThrowingFunction()
//let y:Int?
//do{
//    y = try someThrowingFunction()
//} catch {
//    y = nil
//}
//   表达式时一个错误被抛出,那么这个表 达式的值就是
//某个 throwing 函数实际上在运行时是不会抛出错误的。在这种条件下,你可以在表达式前面写 tr y! 来使错误传递失效

//指定清理操作（defer）
//代码执行到要离开当前的代码段之前去执行一套语句
//该语句让你能够做一些应该被执行 的必要清理工作,不管是以何种方式离开当前的代码段的 - 无论是由于抛出错误而离开,或是因为一条或者 break 的类似语句

//func processFile(filename: String) throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//    }
//}





























































































































































