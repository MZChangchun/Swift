//: Playground - noun: a place where people can play
//为学者日益，为道者日损。损之有损，以至于无为，无为而不为。   大道至简
////////////////////////////////////////////////////////////////////
//							_ooOoo_								  //
//						   o8888888o							  //
//						   88" . "88							  //
//						   (| ^_^ |)							  //
//						   O\  =  /O							  //
//						____/`---'\____							  //
//					  .'  \\|     |//  `.						  //
//					 /  \\|||  :  |||//  \						  //
//				    /  _||||| -:- |||||-  \						  //
//				    |   | \\\  -  /// |   |						  //
//					| \_|  ''\---/''  |   |						  //
//					\  .-\__  `-`  ___/-. /						  //
//				  ___`. .'  /--.--\  `. . ___					  //
//				."" '<  `.___\_<|>_/___.'  >'"".				  //
//			  | | :  `- \`.;`\ _ /`;.`/ - ` : | |				  //
//			  \  \ `-.   \_ __\ /__ _/   .-` /  /                 //
//		========`-.____`-.___\_____/___.-`____.-'========		  //
//				             `=---='                              //
//		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        //
//              佛祖保佑       永无BUG		永不修改                   //
//                 写字楼里写字间，写字间里程序员；                    //
//                 程序人员写程序，又拿程序换酒钱。                    //
//                 酒醒只在网上坐，酒醉还来网下眠；                    //
//                 酒醉酒醒日复日，网上网下年复年。                    //
//                 但愿老死电脑间，不愿鞠躬老板前；                    //
//                 奔驰宝马贵者趣，公交自行程序员。                    //
//                 别人笑我忒疯癫，我笑自己命太贱；                    //
//                 不见满街漂亮妹，哪个归得程序员。                    //
////////////////////////////////////////////////////////////////////

import UIKit

var str = "Hello, playground"


/**
 *  自动引用计数
 */
//引用计数仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("------\(name) is being initialized")
    }
    deinit {
        print("-------\(name) is being deinitialized")
    }
}

//可选类型，值回被自动初始化为nil
var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Applessed")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
reference3 = nil

/**
 *  循环强引用
 */
class Person2 {//人
    let name: String
    init(name: String) {self.name = name}
    var appartment: ApartMent?
    deinit {print("\(name) is being deinitialized")}
}
class ApartMent {//公寓
    let unit:String
    init(unit: String) {self.unit = unit}
    var tenant: Person2?
    deinit {print("Apartment \(unit) is being deinitialized")}
}
var john: Person2?
var unit4A: ApartMent?
john = Person2(name: "John Appleseed")
unit4A = ApartMent(unit: "4A")

//john!.appartment = unit4A
//unit4A!.tenant = john
//
//john = nil
//unit4A = nil

//解决强引用方法： 弱引用（weak reference）   无主引用（unowned reference）




/**
 *  111111111111111111111
 */
//Person 和 Apartment 的例子展示了两个属性的值都允许为 nil ,并会潜在的产生循环强引用。这种场景最适合用 弱引用来解决。

//公寓和它其 中的居民
class Person3 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment3?
    deinit { print("\(name) 333 is being deinitialized") }
}
class Apartment3 {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person3?
    deinit { print("Apartment \(unit) 333 is being deinitialized") }
}
var john3: Person3?
var unit4A3: Apartment3?
john3 = Person3(name: "John Appleseed")
unit4A3 = Apartment3(unit: "4A")

john3 = nil
unit4A3 = nil



/**
 *  222222222222222222222222
 */
//Customer 和 CreditCard 的例子展示了一个属性的值允许为 nil ,而另一个属性的值不允许为 nil ,这也可能会 产生循环强引用。这种场景最适合通过无主引用来解决。

//无主引用和弱引用不同的是，无主引用是永远有值的，是非可选类型（非可选类型不能为 nil ）

//一个客户可能有或者没有信用卡,但是一张信用卡总是关联着一个客户

class Custom {//客户
    let name: String
    var card: CreditCard?
    init(name: String){ self.name = name}
    deinit {print("*******\(name) is being deinitialized")}
}
class CreditCard {//信用卡
    let number: UInt64 //以确保 number 属性的存储量在32 位和64位系统上都能足够容纳16位的卡号
    unowned let customer: Custom
    init(number: UInt64, customer: Custom) {
        self.number = number
        self.customer = customer
    }
    deinit {print("Card #\(number) is being deinitialized")}
}

var john4: Custom?
john4 = Custom(name: "John Applessed")
john4!.card = CreditCard(number: 1234_5678_9012_3456, customer: john4!)

john4 = nil



/**
 *  3333333333333333
 */
//然而,存在着第三种场景,在这种场景中,两个属性都必须有值,并且初始化完成后永远不会为 nil 。在这种场 景中,需要一个类使用无主属性,而另外一个类使用隐式解析可选属性。

//每个国家 必须有首都,每个城市必须属于一个国家
class Country {
    let name: String
    var captialCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.captialCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
//为了建立两个类的依赖关系, City 的构造函数有一个 Country 实例的参数,并且将实例保存为 country 属性。
//Country 的构造函数调用了 City 的构造函数。然而,只有 Country 的实例完全初始化完后, Country 的构造函 数才能把 self 传给 City 的构造函数。(在两段式构造过程 (页 0)中有具体描述)
//为了满足这种需求,通过在类型结尾处加上感叹号( City! )的方式,将 Country 的 capitalCity 属性声明为隐 式解析可选类型的属性。这表示像其他可选类型一样, capitalCity 属性的默认值为 nil ,但是不需要展开它的 值就能访问它。(在隐式解析可选类型 (页 0)中有描述)
//由于 capitalCity 默认值为 nil ,一旦 Country 的实例在构造函数中给 name 属性赋值后,整个初始化过程就完 成了。这代表一旦 name 属性被赋值后, Country 的构造函数就能引用并传递隐式的 self 。 Country 的构造函数 在赋值 capitalCity 时,就能将 self 作为参数传递给 City 的构造函数。
//以上的意义在于你可以通过一条语句同时创建 Country 和 City 的实例,而不产生循环强引用,并且 的属性能被直接访问,而不需要通过感叹号来展开它的可选值:
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s captital city is called \(country.captialCity.name)")







/**
 *  闭包引起的循环强引用(closuer capture list)
 */
//这个 闭包体中可能访问了实例的某个属性,例如 self.someProperty ,或者闭包中调用了实例的某个方法,例如 sel f.someMethod 。这两种情况都导致了闭包 “捕获" self ,从而产生了循环强引用。
//Swift 提供了一种优雅的方法来解决这个问题,称之为闭包捕获列表(closuer capture list)

class HTMLElement {
    let name: String
    let text: String?
    lazy var asHTML: Void -> String = {//虽然闭包多次使用了self,它只捕获HTMLElement 实例的一个强引用
        if let text = self.text {
            return "<\(self.name)>\(text)/\(self.name)"
        } else {
            return "<\(self.name)/>"
        }
    }
    init(name: String, text: String?=nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("ssssssssssssss \(name) is being deinitialized")
    }
}
//asHTML 声明为 lazy 属性,因为只有当元素确实需要处理为HTML输出的字符串时,才需要使用 asHTML 。也就是说,在默认的闭包中可以使用 self ,因为只有当初始化完成以及 self 确实存在后,才能访问 lazy 属性。
let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)<\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello,world")
print(paragraph!.asHTML())

paragraph = nil

//解决办法（）
//声明每个捕获的引用为弱引用或无主引用,而不是强引用
//Swift 有如下要求:只要在闭包内使用self的成员,就要用 self.someProprtyu或者self.someMetho() (而不只是someProperty或someMethod())。这提醒你可能会一不小心就捕获了 。

//如果闭包有参数列表和返回类型,把捕获列表放在它们前面:
//lazy var someClosure: (Int, String) -> String = {
//    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
//    // closure body goes here
//}

//如果闭包没有指明参数列表或者返回类型,即它们会通过上下文推断,那么可以把捕获列表和关键字 in 放在闭包 最开始的地方:
//lazy var someClosure: Void -> String = {
//    [unowned self, weak delegate = self.delegate!] in
//    // closure body goes here
//}

class HTMLElement2 {
    let name: String
    let text: String?
    lazy var asHTML: Void -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("============\(name) is being deinitialized")
    }
    
}

var paragraph2: HTMLElement2? = HTMLElement2(name: "p", text: "hello, world")
print(paragraph2!.asHTML)
paragraph2 = nil







































































































































































































































