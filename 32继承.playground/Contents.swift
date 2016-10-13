//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  继承
 */
/*
 继承类叫子类(subclass),被继承类叫超类(或父类,superclass)
 
 一个类可以继承(inherit)另一个类的方法(methods),属性(properties)和其它特性。
 类可以调用和访问超类的方法,属性和下标脚本(subscripts),并且可以重写(override)这些 方法,属性和下标脚本来优化或修改它们的行为
 
 可以为类中继承来的属性添加属性观察器(property observers),这样一来,当属性值改变时,类就会被通知 到。可以为任何属性添加属性观察器,无论它原本被定义为存储型属性(stored property)还是计算型属性(co mputed property)
 */

//不继承于其他类的类叫基类（base class）
//中的类并不是从一个通用的基类继承而来。如果你不为你定义的类指定一个超类的话,这个类就自动成为基类。区别于OC的NSObject

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {//什么也不做，因为车辆不一定有噪音
        print("ddddddd")
    }
}

let someVehicle = Vehicle()
print("Vehicle :\(someVehicle.description)")

//子类
class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Biicycle:\(bicycle.description)")

class Tandem:Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem:\(tandem.description)")

//重写方法(override)
class Train: Vehicle {
    override func makeNoise() {
        super.makeNoise()
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()

//重写属性
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 25.5
car.gear = 3
print("Car:\(car.description)")

//重写属性观察器（不可以同时提供重写的 setter 和 重写的属性观察器）
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar:\(automatic.description)")



//防止重写 (final)































































































































































