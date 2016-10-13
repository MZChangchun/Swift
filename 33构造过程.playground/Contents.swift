//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 构造过程（initialization）
 */
/*
 构造过程是使用类，结构体或者枚举一个实例的准备过程。
 通过定义构造器(initializers)来实现构造过程 无需返回值（OC需要返回自己）
 析构器（deinitializer） 类的实例也可以通过定义析构器在释放之前执行特定的清除工作
 */



/**
 *  存储属性的初始赋值
 */
//当为存储类型属性设置默认值或者在构造器中赋值的时候，是被直接设置，不会触发任何属性观察者


/**
 *  构造器 （init）
 */

struct Fahrenheit {//华氏温度结构体
//    var temperature: Double
    var temperature = 32.0  //一样，不过这种更好，使用默认值让属性的初始化和声明结合的更紧密。使用默认值能让你的构造器更简洁、更清晰,且能通过默认值自动推导出属性的类型;同时,它也能让你充分利用默认构造器、构造器继承等特性(
    init() {
//        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature) Fahrenheit")



/**
 *  构造参数
 */
struct Celsius {//摄氏温度结构体
    var temperatureInCelsius: Double
    init(formFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(formKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
//如果你在定义构造器时没有提供参数的外部名 字,Swift 会为每个构造器的参数自动生成一个跟内部名字相同的外部名,就相当于在每个构造参数之前加了一 个哈希符号（使用下划线_久不需要了）
let boilingPointOfWater = Celsius(formFahrenheit: 212.0)
print(boilingPointOfWater.temperatureInCelsius)
let freezingPointOfWater = Celsius(formKelvin: 273.15)
print(freezingPointOfWater.temperatureInCelsius)

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}
//let veryGreen = Color(0.0, 1.0, 0.0) // 报编译时错误,需要外部名称
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

/**
 *  不带外部名的构造器参数
 */
//如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线（_）来显示描述她的外部名，以此重写上面的默认行为
struct Celsius2 {
    var temperatureInCelsius: Double = 0.0
    init(formFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(formKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius2(37.0)
print(bodyTemperature.temperatureInCelsius)



/**
 *  可选属性类型 （?）
 */
//定制的类型包含一个逻辑上允许取值为空的存储型属性  --  不管是因为它无法在初始化时赋值,还是因为它 可以在之后某个时间点可以赋值为空--你都需要将它定义为可选类型 optional type 。可选类型的属性将自动初 始化为空 nil ,表示这个属性是故意在初始化时设置为空的。
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."



/**
 *  构造过程中常量属性的修改
 */
//你可以在构造过程中的任意时间点修改常量属性的值,只要在构造过程结束时是一个确定的值。一旦常量属性被
//赋值,它将永远不可更改。
//注意:
//对于类的实例来说,它的常量属性只能在定义它的类的构造过程中修改;不能在子类中修改
class SurveyQuestion2 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion2(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets. (But not with cheese)"



/**
 *  默认构造器
 */
//如果结构体和类的所有属性都有默认值,同时没有自定义的构造器,那么 Swift 会给这些结构体和类创建一个默 认构造器。这个默认构造器将简单的创建一个所有属性值都设置为默认值的实例。
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()




/**
 *  构造器代理
 */
/* 构造器可以通过调用其他构造器来完成实例的部分构造过程，他能减少多个构造器之间的代码重复
 构造器代理的实现规则和形式在 值类型 和  类类型 中有所不同
 
 值类型（结构体和枚举类型） 不支持继承， ，她们只能代理给本身提供其他构造器，构造器代理的过程简单
 类类型（类） 可以继承，类有责任保证其所继承的存储型属性在构造时也能正确的初始化
 对于值类型，可以使用 self.init 在自定义的构造器中引用其他的属于相同值类型的构造器。只能在构造器内部调用self.init
 */
struct Size {
    var width = 0.0, heigh = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.heigh / 2)
        self.init(origin: Point(x:originX, y: originY), size: size)
    }
}
let basicRect = Rect()
print(basicRect)
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, heigh: 5.0))
print(originRect)
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, heigh: 3.0))
print(centerRect)


/**
 *  类的继承和构造过程
 */
/*
类里面的所有存储型属性--包括所有继承自父类的属性--都必须在构造过程中设置初始值
Swift 提供了两种类型的类构造器来确保所有类实例中存储型属性都能获得初始值,它们分别是 指定构造器 和 便利构造器。

指定构造器（最主要的，至少一个） 初始化类中所提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化
便利构造器（次要） 需要调用本类中的指定构造器
    init(parameters) {//指定构造器
        statements
    }
    convenience init(parameters) {//便利构造器
        statements
    }
*/




/**
 *  类的构造器代理规则
 */
//规则 1 指定构造器必须调用其直接父类的的指定构造器。
//规则 2 便利构造器必须调用同一类中定义的其它构造器。
//规则 3 便利构造器必须最终以调用一个指定构造器结束。
//指定构造器必须总是向上代理 • 便利构造器必须总是横向代理




/**
 *  两段式构造过程
 */
//类构造过程包含两个阶段
//1。每个存储型属性通过引入他们的类构造器来设置初始值
//2。每个存储型属性值被确定后开始。 给每个类一次机会在新实例准备使用之前进一步制定他们的存储型属性

//优点：
//构造过程更安全,同时在整个类层级结构中给予了每个类完全的灵活性。两段式构造过程可以防止属性值在初始化之前被访问;也可以防止属性被另外一个构造器意外地赋予不同的值

//和OC不同之处：
//主要的区别在于阶段 1,Objective-C 给每一个 属性赋值 0 或空值(比如说 0 或 nil )。Swift 的构造流程则更加灵活,它允许你设置定制的初始值,并自如 应对某些属性不能以 0 或 nil 作为合法默认值的情况。


/**
 *  构造器的继承和重写（override）
 */
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
    init(){print("ddddddddddd")}
}
var vehicle = Vehicle()
print("Vehicle : \(vehicle.description)")
class Bicycle: Vehicle {
    override init(){
        super.init()
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")



/**
 *  指定构造器和便利构造器实例(convenience)
 */
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
        print("ddddddddddd")
    }
}
let namedMeat = Food(name: "Bacon")
print(namedMeat.name)
let mysteryMeat = Food()
print(mysteryMeat.name)

class RecipeIngredient: Food {
    var quantity : Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let oneMysteryItem = RecipeIngredient()
print(oneMysteryItem.name)
let oneBacon = RecipeIngredient(name: "Bacon")
print(oneBacon.name)
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
print(sixEggs.name)

class ShoppingListItem2: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "?":"?"
        return output
    }
}

var breakfastList = [
    ShoppingListItem2(),
    ShoppingListItem2(name: "Bacon"),
    ShoppingListItem2(name: "Eggs", quantity: 6)
]

breakfastList[0].name = "orange juice"
breakfastList[0].purchased = true
for items in breakfastList {
    print(items.description)
}



/**
 *  可失败构造器(init?)
 */
//如果一个类，结构体或者枚举类的对象，在构造自身的过程中有可能失败，则需要为其定义一个可失败构造器
//失败： 给构造器传入无效的参数值，或缺少某种所需的外部资源，又或者不满足某种必要的条件等

//return nil  严格来说,构造器都不支持返回值。因为构造器本身的作用,只是为了能确保对象自身能被正确构 建。所以即使你在表明可失败构造器,失败的这种情况下,用到了 return nil 。也不要在表明可失败构造器成 功的这种情况下,使用关键字 return 。

//值类型(如结构体或枚举类型)的可失败构造器,对何时何地触发构造失败这个行为没有任何的限制
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymouseCreature = Animal(species: "")
if anonymouseCreature == nil {
    print("The anonymous creature could not be initialized")
}

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

//带原始值的枚举类可失败构造器

enum TemperatureUnit2: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit2 = TemperatureUnit2(rawValue: "F")
if fahrenheitUnit2 != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
let unknownUnit2 = TemperatureUnit2(rawValue: "F")
if unknownUnit2 == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}



/**
 *    类的可失败构造器
 */
//值类型(如结构体或枚举类型)的可失败构造器,对何时何地触发构造失败这个行为没有任何的限制
//类的可失败构造器只能在所有的类属性被初始化后和所有类之间的构造器之间的代理调用发生完后触发失败行为
class Product {
    let name: String!
    init?(name: String) {
        self.name = name
        if name.isEmpty {
            return nil
        }
    }
}

if let bowTie = Product(name: "bow tie") {
    print("The product's name is \(bowTie.name)")
}

//构造失败的传递
class CarItem: Product {
    let quantity: Int!
    init?(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
        if quantity < 1 {
            return nil
        }
    }
}
if let twoSocks = CarItem(name: "sock", quantity: 2) {
    print("Item:\(twoSocks.name), quantity: \(twoSocks.quantity)")
}
if let zeroShirts = CarItem(name: "shirt", quantity: 0) {
    print("Item:\(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
if let oneUnnamed = CarItem(name:"", quantity: 1) {
    print("Item:\(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unname product")
}

//重写一个可失败构造器
//一个非可失败的构造器永远也不能代理调用一个可失败构造器
class Document {
    var name: String?
    init(){}
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}
class AutomaticallyNamedDocument: Document {
    override init(){
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if  name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}
//必要构造器（required）
//    所有该类的子类都必须实现该构造器:
//    如果子类继承的构造器能满足必要构造器的需求,则你无需显示的在子类中提供必要构造器的实现
class SomeClass {
    required init() {
    }
}
    class SomeSubclass: SomeClass {
        required init() {
        }
}

//闭包和函数设置属性的默认值
//    class SomeClass2 {
//        let someProperty: SomeType = {
//            //在这个闭包中给soemProperty创建一个默认值
//            //someValue必须鹤SomeType类型相同
//            return someValue
//        }()   //大括号后面接了一对空的小括号。这是用来告诉 Swift 需要立刻执行此闭包。如果你忽略了这对 括号,相当于是将闭包本身作为值赋值给了属性,而不是将闭包的返回值赋值给属性
//}

struct Checkboard2 {
    let boardColors:[Bool] = {
        var temporaryBoard = [Bool]()
            var isBlack = false
            for i in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            return temporaryBoard
        }()
        func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
            return boardColors[(row * 10) + column]
        }
}

let board2 = Checkboard2()
print(board2.squareIsBlackAtRow(0, column: 1))
print(board2.squareIsBlackAtRow(0, column: 9))
print(board2.squareIsBlackAtRow(0, column: 2))











































































