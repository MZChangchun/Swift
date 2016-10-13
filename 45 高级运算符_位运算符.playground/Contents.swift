//: Playground - noun: a place where people can play

import UIKit

var str                 = "Hello, playground"

//swift中的算术运算符默认不会溢出。所有的溢出行为会被捕获并报告为错误
//如果想让系统允许溢出行为，需要使用另外一套支持溢出的运算符。都是以&开头的


/**
 *  位运算符
 */
//可以操作一个数据结构中每个独立的位。多用于底层开发如图形变成和创建设备驱动，自定义通信协议传输的数据进行编码和解码

//－－－－按位取反运算符 ~ (Bitwise NOT Operator)
//可以对一个数值的全部位取反，1-0 0-1
let initialBits: UInt8  = 0b00001111// 8 个比特位,00001111
let invertedBits        = ~initialBits//11110000

//－－－－按位与运算符 & （Bitwise AND Operator）
//可以对两个数的比特位进行合并，返回一个新的数，只有当两个操作数的对应位都是1的时候才返回1
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits      = firstSixBits & lastSixBits//00111100

//－－－－按位或运算符 | (Bitwise OR Operator)
//对两个数的比特位进行比较，有任意一个为1时返回1
let someBits: UInt8     = 0b10110010
let moreBits: UInt8     = 0b01011110
let combinedbits        = someBits | moreBits

//按位异或运算符 ^ (Bitwise XOR Operator)
//对两个数的比特位进行比较，当对应位不相同时返回1
let firstBits: UInt8    = 0b00010100
let otherBits: UInt8    = 0b00000101
let outputBits          = firstBits ^ otherBits



/**
 *  按位左移/右移运算符 << >> (Bitwise Left and Right Shift Operators)
 */
//相当于对这个数进行乘以2（左移）或除以2（右移）的运算

//1111111111111111111111111无符号整形的移位操作（逻辑位移）
            //已经存在的比特位按指定的位数左移右移
            //任何移动超出整形存储边界的位都会被丢弃
            //用0填充移位后产生的空白
let shiftBits: UInt8    = 4// 即二进制的00000100
shiftBits << 1// 00001000
shiftBits << 2// 00010000
shiftBits << 5// 10000000
shiftBits << 6// 00000000
shiftBits >> 2// 00000001

//可以使用移位操作对其他数据类型进行编码和解码
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16
let greenComponent = (pink & 0x00FF00) >> 8
let blueComponent = pink & 0x0000FF


//22222222222222222222222有符号整形的移位操作
//符号位位0，说明时正数，另外代表二进制
//4 == 0b00000100

//负数的存储方式：2的n次方减去绝对值（n表示位数）
//-4 == 0b1111100  (128 - 4 = 124) （反码＋1）
//负数的表示称为，二进制补码




/**
 *  溢出运算符
 */
//默认情况下，当一个整数赋值超过他的容量的时候，会报错 不生成无效数。更安全
//Int16 范围是 －32768 到 32767
var potentialOverflow = Int16.max
//potentialOverflow += 1 //会报错

//可以选择让系统在数值溢出的时候采取截断操作。可以使用swift的是三个溢出操作符（overflow operators）
            //溢出加法&+
            //溢出减法&-
            //溢出乘法&*




/**
 *  数值溢出
 */


//无符号

var unsignedOverflow = UInt8.max
unsignedOverflow = unsignedOverflow &+ 1
var unsignedOverflowMin = UInt8.min
unsignedOverflowMin = unsignedOverflowMin &- 1

//有符号
//符号位也要参与计算
var signedOverflow = Int8.min
signedOverflow = signedOverflow &- 1
var signedOverflowMin = Int8.max
signedOverflow = signedOverflow &+ 1



/**
 *  优先级和结合性
 */
//优先级 高优先级的运算符会先被计算
//结合性 左结合和右结合




/**
 *  运算符重载（运算符函数）
 */
//111111111111111111111111111111111111111111中缀
//类和结构体可以为现有的操作符提供自定义的实现，被称为运算符重载（overloading）
struct Vector2D {
    var x = 0.0, y = 0.0
}
//这个函数被定义为全局的而不是Vector2D的成员方法，所以人一两个vector2D承欢都可以使用者歌中缀运算符
func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}
let vector = Vector2D(x: 3.0, y: 2.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combineVector = vector + anotherVector

//222222222222222222222222222222222222222前缀和后缀运算符
//实现前缀或者后缀运算符，需要在声明运算符函数的时候在func 关键字之前制定prefix 或者 postfix限定符
prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}
let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
let alsoPositive = -negative

func += (inout left: Vector2D, right: Vector2D) {
    left = left + right
}
var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd

prefix func ++ (inout vector: Vector2D) -> Vector2D {
    vector += Vector2D(x: 1.0, y: 1.0)
    return vector
}
var toIncrrment = Vector2D(x: 3.0, y: 4.0)
let afterIncrement = ++toIncrrment


//333333333333333333333333333333333333333等价操作符
//自定义的类和结构体没有对等价操作符进行默认实现， == !=
//swift无法判断 自定义类型 是否相等，因为相等的含义取决于这些自定义类型在代码中所扮演的角色
func ==(left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}
func !=(left :Vector2D, right:Vector2D) -> Bool {
    return !(left == right)
}


//44444444444444444444444444444444444444444自定义运算符 (operator [prefix infix postfix])
prefix operator +++{}
prefix func +++(inout vector: Vector2D) -> Vector2D {
    vector += vector
    return vector
}





/**
 *  自定义中缀运算符的优先级和结合性
 */
//自定义中缀运算符infix
//结合性 associativity（left right none（默认，不能和其他相同优先级的运算符写在一起））
//优先级 precedence （如果没有指定，默认100）
infix operator +- {associativity left precedence 140}
func +-(left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y)
}

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector




















































































































































