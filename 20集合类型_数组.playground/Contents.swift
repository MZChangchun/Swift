//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  集合类型(泛类集合)
 */
//数组（Arrays）有序
//集合（Sets）无序无重复数据集
//字典（Dictionaries）无序键值对

/**
 *  shuzu
 */
//遵循像 Array<Element> 这样的形式,其中 Element 是这个数组中唯一允许存在的数据类 型。我们也可以使用像 [Element] 这样的简单语法。尽管两种形式在功能上是一样的,但是推荐较短的那种,而 且在本文中都会使用这种形式来使用数组。

//－－－－－－－－－－创建空数组
var someInts = [Int]()//定义一个Int类型空数组，通过构造函数的类型被推断为Int
someInts.append(3)//添加一个元素Int值3
someInts = []//数组设置为空，但仍然是［Int］

//－－－－－－－－－－创建有默认值的数组
var threeDoubles = [Double](count: 3, repeatedValue:0.0)//初始化数组，三个元素，每个都是0.0

//－－－－－－－－－－两个数组相加创建数组
var anotherThreeDoubles = Array(count: 3, repeatedValue:2.5)
var sixDoubles = threeDoubles + anotherThreeDoubles

//－－－－－－－－－－用字面量构造数组
var shoppingList: [String] = ["Eggs", "Milk"]
//相当于 var shoppingList = ["Eggs", "Milk"]


//数组操作
//可以通过数组的方法和属性来访问和修改数组，活着使用下标语法

//只读属性count获取数组中的数据项数量(个数)
print("The shopping list contains \(shoppingList.count) items")

//使用不二之属性isEmpty检查count属性是否为0(空数组)
if shoppingList.isEmpty {
    print("这是个空数组")
} else {
    print("这不是个空数组")
}

//数组添加元素
shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

//获取数组中元素
var firstItem = shoppingList[0]

//修改数组中元素
shoppingList[0] = "Six eggs"
shoppingList[4...6] = ["Bananas", "Apples"]

//插入数据
shoppingList.insert("Maple Syrup", atIndex: 0)//在索引值前插入元素

//移除元素
let mapleSyrup = shoppingList.removeAtIndex(0)//shoppingList 已经移除 移除的元素赋值给常量mapleSyrup
let apples = shoppingList.removeLast()//移除最后一项

//数组的遍历
for item in shoppingList {
    print(item)
}
//根据数据项值和索引值
for (index, value) in shoppingList.enumerate() {
    print("Item \(String(index + 1)): \t\(value)")
}


