//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

if #available(iOS 9,OSX 10.10, *) {//* ,是必须写的,用于处理未来潜在的平台。
    print("在iOS使用iOS9的API， 在OS X中使用OS X 10.10的API")
} else {
    print("使用先前版本的iOS和OS X的API")
}

//获取一系列的平台名字和版本
//if #available(platform name version, ..., *) {
//    statements to execute if the APIs are available
//} else {
//    fallback statements to execute if the APIs are unavailable
//}