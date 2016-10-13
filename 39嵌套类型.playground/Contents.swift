//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  嵌套类型 ｛｝
 */
//在一个类型中嵌套另一个类型，需要将嵌套的类型的定义写在被嵌套类型的区域{}中。可以多级嵌套

struct BlackjackCard {
    //嵌套定义枚举类型
    enum Suit: Character {//花色
        case Spades = "M", Hearts = "R", Diamnods = "F", Clubs = "B"
    }
    
    //嵌套定义枚举类型
    enum Rank: Int { //牌面
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    //BlackjackCard的属性和方法
    let rank: Rank, suit: Suit
    var desctiption: String {
        var output = "suit is \(suit.rawValue),"
        output += "value is \(rank.values.first)"
        if let second = rank.values.second {
            output += "or \(second)"
        }
        return output
    }
}
//尽管 Rank 和 Suit 嵌套在 BlackjackCard 中,但仍可被引用
let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
print(theAceOfSpades.desctiption)


//在外部对嵌套类型的引用,以被嵌套类型的名字为前缀,加上所要引用的属性名:
let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue




















































































































































































































