//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  协议
 */
//协议的语法
//protocol SomeProtocol {协议内容}

//要使类遵循某个协议,需要在类型名称后加上协议名称,中间以冒号 : 分隔,作为类型定义的一部分。遵循多个 协议时,各协议之间用逗号 , 分隔。
//struct SomeStructure: FirstProtocol, AnotherProctocol {结构体内容}

//如果类在遵循协议的同时拥有父类,应该将父类名放在协议名之前,以逗号分隔。
//struct SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {类的内容}



//协议中的通常用var来声明变量属性,在类型声明后加上 { set get } 来表示属性是可读可写的,只读属性则用 { get } 来表示。
//如果协议规定属性是可读可写的,那么这个属性不能是常量或只读的计算属性。如果协议只要求属性是只读的(ge ttable),那个属性不仅可以是只读的,如果你代码需要的话,也可以是可写的。
protocol SomeProtocol1 {
    var mustBeSettable: Int {get set}
    var doesNotNeedToBeSettable: Int {get}
}

//在协议中定义类属性(type property)时,总是使用 static 关键字作为前缀。当协议的遵循者是类时,可以使用 class 或 static 关键字来声明类属性:
protocol AnotherProtocol {
    static var someTypeProperty: Int {get set}
}


protocol FullyNamed {
    var fullName: String{get}
}
struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Applessed")


class Startship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Startship(name: "Enterprise", prefix: "USS")
print(ncc1701.fullName)



/**
 *  方法的规定
 */
protocol RandomNumberGenerator {
    func random() -> Double
}

//线性同余生成器(linear congruential generator)的伪随机数算法
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")




/**
 *  Mutating 方法的规定
 */
//有时需要在方法中改变它的实例,你在协议中定义了一个方法旨在改变遵循该协议的实例,那么在协议定义时需要在方法前加关键字
//用类实现协议中的 mutating 方法时,不用写 mutating 关键字;用结构体,枚举实现协议中的 mutating 方法 时,必须写 mutating 关键字。
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()





/**
 *  对构造器的规定
 */
//你可以在遵循该协议的类中实现构造器,并指定其为类的指定构造器(designated initializer)或者便利构造 器(convenience initializer)。在这两种情况下,你都必须给构造器实现标上"required"修饰符
//如果类已经被标记为 final ,那么不需要在协议构造器的实现中使用 required 修饰符。因为final类不能有子 类
protocol SomeProtocol {
    init(someParameter: Int)
}
class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        //构造器实现
    }
}


protocol SomeProtocol2 {
    init()
}
class SomeSuperClass2 {
    init() {
        //构造器的实现
    }
}
class SomeSubClass: SomeSuperClass2, SomeProtocol2 {
    
    //因为遵循协议，需要加上“required”;因为继承自父类，所以要加上“override”
    required override init() {
        //构造器的实现
    }
}



/**
 *  协议类型
 */
//协议本身并不实现任何功能，但是协议可以被当作类型来使用
//作为 函数 ， 方法 或 构造器中的参数类型 或 返回值
//作为常量变量或属性的类型
//作为数组字典或其他容器中的元素类型

//协议当做类型使用
class Dice { //🎲
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func rool() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.rool())")
}


/**
 *  委托代理模式
 */
//类或者结构体将一些需要他们负责的功能交给（委托给）其他的类型的实例。
//定义协议：封装需要被委托的函数和方法 使遵循着拥有这些被委托的函数和方法
protocol DiceGame {
    var dice: Dice {get}
    func play()
}
protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(game: DiceGame)
}


class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides:6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.rool()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides) - sided dice")
    }
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


/**
 *  在扩展中添加协议成员
 */
protocol TextRepersentable {
    var textualDescription: String{get}
}
extension Dice: TextRepersentable{
    var textualDescription: String {
        return "A \(sides) - suded dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakesAndLadders: TextRepersentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) square"
    }
}
print(game.textualDescription)


/**
 *  通过扩展补充协议声明
 */
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepersentable{}
let simonTHeHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepersentable = simonTHeHamster//即使满足了协议的所有要求,类型也不会自动转变,因此你必须为它做出显式的协议声明。

print(somethingTextRepresentable.textualDescription)


/**
 *  协议类型的集合
 */
let things: [TextRepersentable] = [game, d12, simonTHeHamster]
for thing in things {
    print(thing.textualDescription)
}



/**
 *  协议的继承
 */
protocol PrettyTextRePresentable: TextRepersentable {
    var prettyTextualDescription: String {get}
}
extension SnakesAndLadders: PrettyTextRePresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}
print(game.prettyTextualDescription)



























































