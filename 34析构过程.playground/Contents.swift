//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/**
 *  析构过程（Deinitialization）
 */
//析构器只适用于类类型，当一个类的实例在释放前，析构器会被立即调用。（deinit）
//deinit {
//    //执行析构过程
//}

struct Bank {
    static var coinsInBank = 10_000
    static func vendCoins(var numberOfCoinsToVend: Int) -> Int {
        numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func recriveCoins(coins: Int) {
        coinsInBank += coins
    }
}
class Player {
    var coinsInPurse: Int//钱包
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(coins)
    }
    func winCoins(coins: Int) {
        coinsInPurse += Bank.vendCoins(coins)
    }
    deinit {
        Bank.recriveCoins(coinsInPurse)
    }
}

var playerOne:Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")

playerOne!.winCoins(2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
print("The bank now only has \(Bank.coinsInBank) coins left")

playerOne = nil
print("PlayerOne has left the game")
print("The bank now has \(Bank.coinsInBank) coins")























































































































































































































































