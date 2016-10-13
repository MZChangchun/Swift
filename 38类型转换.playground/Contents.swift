//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/**
 *  类型转换
 */
//可以判断实例的类型,也可以将实例看做是其父类或者子类的实例。 is 和 as
//父类
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}
//子类
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}
//子类2
class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
//在幕后 library 里存储的媒体项依然是 Movie 和 Song 类型的。但是,若你迭代它,依次取出的实例会是 MediaItem 类型的,而不是 Movie 和 Song 类型。为了让它们作为原本的类型工作,你需要检查它们的类型或者向下转换它们到其它类型,就像下面描述的一样



//检查类型  is
var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs")


//向下转型  as? as!
//转换没有真的改变实例或它的值。潜在的根本的实例保持不变;只是简单地把它作为它被转换成的类来使用。
for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}




//Any 和 AnyObject的类型转换
//swift 为不确定类型提供了两种特殊类型的别名 
//AnyObject 可以代表任何class类型的实例
//Any 可以表示任何类型，包括方法类型（function types）
let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]
for object in someObjects {
    let movie = object as! Movie
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}
//为了变为一个更短的形式,下转 someObjects 数组为 [Movie] 类型来代替下转数组中每一项的方式。
for movie in someObjects as! [Movie] {
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}



//Any类型
var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as String -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    } }





//数组可以存储不同类型的元素，但是需要声明为AnyObject
let someObjects9: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Song(name: "Alien", artist: "Ridley Scott")
]
for object in someObjects9 {
   if let movie = object as? Movie {
        print("Movie: '\(movie.name)', dir. \(movie.director)")
    } else if let song = object as? Song {
        print("Song: '\(song.name)', dir. \(song.artist)")
    }
}




























































































































































