//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/**
 *  集合类型(泛类集合)
 */
//数组（Arrays）有序
//集合（Sets）无序无重复数据集
//字典（Dictionaries）无序键值对

// 集合是用来存储相同类型并且没有确定顺序的值，当集合元素顺序不重要活着希望确保每个元素只出现一次时使用
//被桥接到Fundation中的NSSet
/*个类型为了存储在集合中,该类型必须是可哈希化的--也就是说,该类型必须提供一个方法来计算它的哈希 值。一个哈希值是 Int 类型的,相等的对象哈希值必须相同,比如 a==b ,因此必须 a.hashValue == b.hashValu e。
 Swift 的所有基本类型(比如 String , Int , Double 和 Bool )默认都是可哈希化的,可以作为集合的值的类型或 者字典的键的类型。没有关联值的枚举成员值(在枚举有讲述)默认也是可哈希化的。
 注意: 你可以使用你自定义的类型作为集合的值的类型或者是字典的键的类型,但你需要使你的自定义类型符合 Swift 标准库中的 Hashable 协议。符合 Hashable 协议的类型需要提供一个类型为 Int 的可读属性 hashValue 。由类 型的 hashValue 属性返回的值不需要在同一程序的不同执行周期或者不同程序之间保持相同。因为 Hashable 协议符合 Equatable 协议,所以符合该协议的类型也必须提供一个"是否相等"运算符( == )的实 现。这个 Equatable 协议要求任何符合 == 实现的实例间都是一种相等的关系。也就是说,对于 a,b,c 三个值来 说, == 的实现必须满足下面三种情况:
 • a == a (自反性)
 • a == b 意味着 b == a (对称性)
 • a == b && b == c 意味着 a == c (传递性)
*/
// Set 类型被写为 Set<Element> ,这里的 Element 表示 Set 中允许存储的类型,和数组不同的是,集 合没有等价的简化形式。

//创建或构造一个空的集合
var letters = Set<Character>()//Set<Character>类型
letters.insert("a")
letters = []

//用数组字面量创建集合
var favoriteGenres :Set <String> = ["Rock", "Classical", "Hip hop"]
//相当于 var favoriteGenres : Set = ["Rock", "Classical", "Hip hop"]

//访问和修改一个集合
print("I have \(favoriteGenres.count) favorite music genres")

if favoriteGenres.isEmpty {
    print("As far as mnusiz goes, I'm not picky")
} else {
    print("I have particular music preferences")
}

//添加新元素
favoriteGenres.insert("Jazz")

//删除元素
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it")
} else {
    print("I never much cared for that.")
}

//检查是否有特定值
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot")
} else {
    print("It's too funky in here")
}

//遍历集合
for genre in favoriteGenres {
    print(genre)
}

//根据提供的序列返回一个有序集合
for genre in favoriteGenres.sort() {
    print(genre)
}

//集合操作：并。交。。。。。。(两个)
let oddDigits : Set = [1, 3, 5, 7, 9]
let evenDigits : Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers : Set = [2, 3, 5, 7]
oddDigits.union(evenDigits).sort()//并集
oddDigits.intersect(evenDigits).sort()//交集
oddDigits.subtract(singleDigitPrimeNumbers).sort()//odd - 交集
oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()// 并集 - 交集

//使用“是否相等”运算符( == )来判断两个集合是否包含全部相同的值。
//    • 使用 isSubsetOf(_:) 方法来判断一个集合中的值是否也被包含在另外一个集合中。
//        • 使用 isSupersetOf(_:) 方法来判断一个集合中包含另一个集合中所有的值。
//            • 使用 isStrictSubsetOf(_:) 或者 isStrictSupersetOf(_:) 方法来判断一个集合是否是另外一个集合的子集合 或者父集合并且两个集合并不相等。
//                • 使用 isDisjointWith(_:) 方法来判断两个集合是否不含有相同的值。


