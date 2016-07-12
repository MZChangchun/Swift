//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  for 循环
 */
for index in 1...5 {
    print("\(index) time 5 is \(index * 5)")
}

var answer = 1
for _ in 1...10 {
    answer *= 3
    print(answer)
}

for var index = 0; index < 3; ++index {
    print("index is \(index)")
}
        

/**
 *  while循环
 */
//while循环，每次在循环开始时计算条件是否符合（while do{}）
//repeat－while循环，每次在循环结束时计算条件是否符合(do{} while)
var i = 0;
while i < 10 {
    i += 1;
    NSLog("\(i)")
}

var j = 0;
repeat {
    j += 1;
    NSLog("\(j)");
}while j < 10

/**
 *  if
 */

let temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print(temperatureInFahrenheit)
} else if temperatureInFahrenheit >= 86 {
    print("too hot!")
} else {
    print("so beautiful feather")
}

/**
 *  switch
 */
//与c语言不一样的是，当匹配case后，会终止switch语句，因此，不需要break（不存在隐式的贯穿 No Implicit Fallthrough）
//警告：：：：：：每一个case分支至少包含一条语句
let somecharacter: Character = "e"
switch somecharacter{
    
case "a", "b", "c":
    print("adsdsdsadsa")
case "e":
    print("sososososos")
case "f"..<"g"://区间匹配
    print("sdsadasdas")
default:
    print("nononononono")
}

//元组中使用下划线来匹配所有可能的值
let somePoint = (1, 1)
switch somePoint {
    
case (0, 0):
    print("sss")
case (_, 0):
    print("dsadsa")
case (1, _):
    print("dssssssssssssssssssssss")
case (_, _):
    print("dddddddddddddddddd")
}

/**
 *  where
 */
//case分支的模式可以使用where语句来判断额外的条件
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("1111")
case let (x, y) where x == -y:
    print("wwwww")
case let (x, y) :
    print("33333333")
}

/**
 *  控制转移语句
 */
//continue break fallthrough（贯穿） return throw（抛出错误）

//swift 中的switch语句不会从上一个分支case落入到下一个分支，
//fallthrough贯穿 可以让switch执行一个case以后，再次进入匹配下面的
let integerToDescribe = 5
var descripe = "the number \(integerToDescribe) is"
switch integerToDescribe {
case 2,3,4,5,6,7:
    descripe += "a primenumber, and also"
    fallthrough
case 5:
    descripe += "2"
default:
    descripe += "aaaaaa"
}


/**
 *  带标签的语句
 */
//可以使用一个标签来标记一个循环或者switch代码块，当使用continue时，可以带上这个标签
//labelname : while condition {statements}
gameLoop : for i in 0...6 {
    for j in 0...6 {
        if j == i {
            continue gameLoop
        }
        print(i * 10 + j)
    }
}

/**
 *  提前退出,必须有else
 */
func greet(person:[String:String]){
    guard let name = person["name"] else {
        return
    }
    print("Hello\(name)")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you")
        return
    }
    print("I hope the weather is nice in \(location)")
    
}

greet(["name":"John"])
greet(["name":"John", "location":"cupertino"])
greet(["location":"cupertino"])








