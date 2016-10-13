//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  泛型
 */
//灵活可重用，避免重复的代码.(许多函数功能都一样，输入值类型不一样 int double float)
//是swift强大特征中的一种。数组和字典类型都是泛型集

//标准函数交换Int值
func swapTwoInts (inout a: Int, inout _ b: Int) {//写入读出(in-out)参数来交换 a 和 b 的值
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print(" someInt is now \(someInt), and anotherInt is now \(anotherInt)")
//swapTwoInts(_:_:) 函数是非常有用的,但是它只能交换 Int 值,如果你想要交换两个 String 或者 Double ,就 不得不写更多的函数
//然而，实际应用中，需要一个强大的尽可能考虑到更多灵活性单个函数
//所有三个函数中, a 和 b 的类型是一样的。如果 a 和 b 不是相同的类型,那它们俩就不能互换值。S wift 是类型安全的语言,所以它不允许一个 String 类型的变量和一个 Double 类型的变量互相交换值。如果一 定要做,Swift 将报编译错误。



//强大的泛型函数
func swapTwoValues<T>(inout a: T, inout _ b: T) { //占位类型名字(通常此情况下用字母T来表示)
    let temporaryA = a
    a = b
    b = temporaryA
}
//占位类型名没有提示必须是什么类型,但是它提示了a和b必须是同一类型,而不管t表示什么类型。只有函数在每次调用时所传入的实际类型才能决定 所代表的类型
//<>函数所定义的一个类型。因为t是一个占位命名类型,Swift 不会去 查找命名为T的实际类型

var someInt2 = 3
var anotherInt2 = 107
swapTwoValues(&someInt2, &anotherInt2)
print("\(someInt2)------\(anotherInt2)")

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
print("\(someString)------\(anotherString)")

/**
 *  类型参数
 */
//你可支持多个类型参数,命名在尖括号中,用逗号分开。<T,X,S,B>

/**
 *  命名类型参数
 */
/**
 *  泛型类型
 */
//通常情况下，swift允许定义自己的泛型类型。
//非泛型版本栈
struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}
//泛型
struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T{
        return items.removeLast()
    }
}
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
print(stackOfStrings.items)

let formTheTop = stackOfStrings.pop()
print(stackOfStrings.items)


/**
 *  扩展泛型类型
 */
extension Stack {
    var topItem:T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}


/**
 *  类型约束
 */
//有时候，对使用在泛型函数和泛型类型上的类型强制约束为某种特定类型是非常有用的。
//指定了一个必须继承自制定类的类型参数，或者遵循一个特定的协议或协议构成
//例如，Dictionary类型对于作用于其键的类型做了些限制（可哈希是为了以便 于其检查其是否已经包含某个特定键的值）

//语法
//func someFuction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//    //这里是函数主体
//}

//findStringIndex(_:_:) 函数可以作用于查找一字符串数组中的某个字符串:
func findStringIndex(array:[String], _ valueToFind: String) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind{
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "llama") {
    print("The index of 11ama is \(foundIndex)")
}

//如果只是针对字符串而言查找在数组中的某个索引值，用处不是很大。可以写成范型
// Equatable 协议.要求任何遵循的 类型实现等式符(==)和不等符(!=)对任何两个该类型进行比较
func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
 let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
 let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")






/**
 *  关联类型 associated type   关键字 associatedtype
 */
//当定义一个协议时，有的时候声明一个或者多个关联类型作为协议定义的一部分，给定类型的一个占位名。
protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int {get}
    subscript(i: Int) ->ItemType {get}
}
struct IntStack2: Container {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func Pop() -> Int {
        return items.removeLast()
    }
    //遵循Container协议的实现
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct Stack3<T>: Container {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    
    mutating func append(item: T) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}

/**
 *  扩展一个存在的类型为一只定关联类型
 */
//如上，swift的Array已经提供了append（：）方法。一个count属性和通过下标查找自己的元素。都达到了Container协议的要求，所以可以扩展Array去遵循container协议
extension Array: Container{}







/**
 *  Where语句
 */
//where语句能够使一个关联类型遵循一个特定的协议，以及（或）那个特定的类型参数和关联类型可以是相同的。
//定一个一个范型函数，检查两个container实例是否包含相同顺序的相同元素
func allItemMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, _ anotherContainer: C2) -> Bool {
    //检查两个container的元素个数是否相同
    if someContainer.count != anotherContainer.count {
        return false
    }
    //检查连个container相应位置的元素是否彼此相等
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    return true
}
//where部分分析： 
//    C1 必须遵循 Container 协议 (写作 C1: Container )。
//    C2 必须遵循 Container 协议 (写作 C2: Container )。
//    C1 的 ItemType 同样是C2的 ItemType (写作 C1.ItemType == C2.ItemType )。
//    C1 的 ItemType 必须遵循 Equatable 协议 (写作 C1.ItemType: Equatable )。

var stackOfStrings2 = Stack3<String>()
stackOfStrings2.push("uno")
stackOfStrings2.push("dos")
stackOfStrings2.push("tres")

var arrayOfStrings2 = ["uno", "dos", "tres"]

if allItemMatch(stackOfStrings2, arrayOfStrings2) {
    print("All items match")
} else {
    print("Not all items match")
}



















































































































































































