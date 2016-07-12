//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


var nameOfIntegers = [Int: String]()

nameOfIntegers[16] = "sixTeen"
nameOfIntegers = [:]

var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
var airportss  = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

print(airports.count)

if airports.isEmpty {
    print("空")
} else {
    print("不空")
}

airports["LHR"] = "London"//添加
airports["LHR"] = "London Heathrow"//修改

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print(oldValue)
}

if let airportName = airports["DUB"] {
    print(airportName)
}

airports["APL"] = "Apple Internation"
airports["APL"] = nil//移除

if let removedValue = airports.removeValueForKey("DUB") {
    print(removedValue)
}

//遍历
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

for airportCode in airports.keys {
    print(airportCode)
}

//键集合 或者 值集合
let airportCodes = [String](airports.keys.sort())
let airportNames = [String](airports.values.sort())


