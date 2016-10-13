//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  访问控制
 */
//可以限定 其他源文件或模块中代码 对 你代码 的访问级别。隐藏功能实现的细节。
//模块：以独立单元构建和发布的Framework 或 Application。 可以使用 import 引入另外一个模块
//源文件： 指swift中的swift file。就是编写swift源代码的文件，它通常属于一个模块。

//public: 可以访问自己模块中源文件里的任何实体,别人也可以通过引入该模块来访问源文件里的所有实 体。通常情况下,   中的某个接口是可以被任何人使用时,你可以将其设置为  public 级别
//internal: 可以访问自己模块中源文件里的任何实体。但是别人不能访问该模块中源文件里的实体
//private：只能在当前源文件中使用的实体。也可以用作隐藏某些功能的实现细节

//swift 中 private 访问和其他语言不一样，他的范围限于整个源文件，而不是声明。
//意味着，一个类可以给访问定义该类的源文件中所有 private 实体，但是如果一个类的扩展是定义在独立的源文件中，那么就不能访问这个类的 private 成员

// public 为最高级访问级别, private 为最低级访问级别


/**
 *  使用原则
 */
//一个 public 访问级别的变量，不能将它的类型定义为 internal 和 private 。因为变量可以被任何人访问，但是定义它的类型不可以，所以这样就会出现错误。
//函数的访问级别不能高于他的参数，返回类型的访问级别。因为如果函数定义为 public 而参数或者返回类型定义为 internal 或 private ，就会出阿仙函数可以被任何人访问，但是他的参数和返回类型却不可以，同样会出现错误


//默认的访问级别是internal 因为我们一班都是在开发一个 app bundle

//单目标应用程序的访问级别
//该应用的所有功能都是为该应用服务，不需要提供给其他应用或者模块使用，所以不需要设置明确的访问级别。使用默认 internal 即可。也可使用 private ，用于隐藏一些功能的实现细节

//framework 的访问级别
//需要把一些对外的借口定义为 public 级别，以便他人导入该 Framework 后可以正常使用功能，其实就是 API

//单元测试目标的访问级别
//当有单元测试时，为了方便，测试模块要能访问到app中的代码。默认情况下只有 public 才能被其他模块访问，然而， 在引入一个生产模块时使用 @testable 注解，然后用带测试的方式编译这个生产模块，单元测试目标就可以访问所有 internal 级别的实体





/**
 *  语法
 */
//public class SomePublicClass {}
//internal class SomeInternalClass{}
//private class SomePrivateClass{}
//
//public var somePublicVariable = 0
//internal let someInternalConstant = 0
//private func somePrivateFunction(){}


/**
 *  自定义类型
 */
public class SomePublicClass {// 显式的 public 类
    public var somePublicProperty = 0// 显式的 public 类成员
    var someInternalProperty      = 0// 隐式的 internal 类成员
    private func somePrivateMethod(){}// 显式的 private 类成员

}

class SomeInternalClass { // 隐式的 internal 类
    var someInternalProperty      = 0// 隐式的 internal 类成员
    private func somePrivateMethod() {} // 显式的 private 类成员
}
private class SomePrivateClass {// 显式的 private 类
    var somePrivateProperty       = 0// 隐式的 private 类成员
    func somePrivateMethod() {}// 隐式的 private 类成员
}

/**
 *  元组类型
 */
//元组的访问级别使用时所有类型的访问级别使用中最为严谨的。如果你构建一个包含两种不同类型元素 的元组,其中一个元素类型的访问级别为   ,另一个为   级别,那么这个元组的访问级别为。也就是说元组的访问级别与元组中访问级别最低的类型一致。元组不同于类、结构体、枚举、函数那样有单独的定义。元组的访问级别是在它被使用时自动推导出的,而不是明确的申明


/**
 *  函数类型
 */
//函数的访问级别需要根据该函数的参数类型和返回类型的访问级别得出
//private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
//    // function implementation goes here
//}
//返回类型是一个元组，其中一个类的访问级别是 internal ,另一个的访问级别是 private ，所以是 private。需要显式声明


/**
 *  枚举类型
 */
//枚举中成员的访问级别继承自该枚举，不能单独为成员申明不同的访问级别


/**
 *  原始值和关联值
 */
//枚举定义中的任何原始值或者关联值的类型都必须有一个访问级别，这个级别至少不要第一枚举的访问级别，比如不能在一个 internal 访问级别的枚举中定一个

/**
 *  嵌套类型
 */
//在 private 级别的类型中定义嵌套类型，则该嵌套类型就  自动拥有 private 访问级别
//在 public 活着 internal 级别类型中定义嵌套类型，那么该嵌套类型就  自动拥有 internal 访问能级别
//如果想让嵌套类型拥有 public 访问级别， 需要名曲人的  申明  该嵌套类型的访问能级别


/**
 *  子类
 */
//子类的访问级别不能高于父类的访问能级别

//可以在满足子类不高于父类访问级别一级遵循各访问级别作用域（模块或源文件）的前提下，可以重写人意成员（方法，属性，初始化方法，下标索引）
public class A {
    private func someMethod(){}
}
internal class B: A {
    override internal func someMethod() {
    }
}

//只要满足子类不高于父类访问级别以及遵循各级访问级别作用域的前提下（private 的作用域在同一个源文件中， internal 的作用域在同一个模块下），可以在子类中，用子类访问父类成员，哪怕父类成员的访问级别比子类成员低
public class C {
    private func someMethod(){}
}
internal class D: C {
    override internal func someMethod() {
        super.someMethod()
    }
}


/**
 *  常量，变量，属性，下标
 */
//不能拥有比他们的类型更高的访问级别。
//如果这些定义类型时 private 级别的，必须明确的申明访问级别是 private
private var privateInStance = SomePrivateClass()


/**
 *  Getter Setter
 */
//常量，变量，属性，下标索引的 getter 和 setter 的访问级别继承自它们所属的成员的访问级别
//setter 的访问级别可以低于 getter 以便于控制读写权限。 在 var 或者 subscript 之前通过 private（set）或者 internal（set） 先为它们的写权限申明一个较低的访问级别
struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}
var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked"
stringToEdit.numberOfEdits = 10
stringToEdit.value = "sssss"
print(stringToEdit.numberOfEdits)
//相同模块下，可以修改 。虽然你可以在其他的源文件中实例化该结构体并且获取到 numberOfEdits 的值，但是不能赋值

//如果有必要，可以为getter 和 setter 设定显式访问级别。
//下面就是设置了numberOfEdits 的属性是 public 并设置了他的 Setting 属性的访问级别是private
public struct TrackedString2 {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        } }
    public init() {}
}


/**
 *  初始化
 */
//可以给自定义的初始化方法申明访问级别，但是不要高于他所属的类的访问级别
//必要构造器例外。它的访问级别可以高于所属类的访问级别。
//如果一个类型被申明为 public 级别,那么默认的初始化方法的访问级别为 internal 。如果你想让无参 的初始化方法在其他模块中可以被使用,那么你必须提供一个具有 public 访问级别的无参初始化方法。
//结构体中任一存储属性的访问级别是 private ，那么 他的默认成员初始化方法访问级别就是private。尽管如此，结构体的初始化方法的访问级别依旧是 internal
//如果想在其他模块中使用该结构体的默认成员初始化方法，需要提供一个访问级别为 public 的默认成员初始化方法


/**
 *  协议
 */
//如果想为一个协议明确的申明访问级别，就要确保该协议只在你申明的访问级别作用域中使用。
//协议中的每个必须实现的函数都具有和该协议相同的访问级别。
//如果定义了一个public访问级别的协议，实现该协议提供的必要函数也是public访问级别

//协议继承
//如果定义了一个新的协议,并且该协议继承了一个已知的协议,那么新协议拥有的访问级别最高也只和被继承协 议的访问级别相同

//协议一致性
//类可以采用比自身访问级别低的协议。 public 类 可以采用一个 internal 级别的协议（变成 internal）
//采用了协议的类的访问级别取决于它本身和所采用协议中最低的访问级别
//Swift和Objective-C一样,协议的一致性保证了一个类不可能在同一个程序中用不同的方法采用同一个协议。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。不理解


/**
 *  扩展
 */
//扩展成员应该具有和原始类成员一致的访问级别。
//或者，可以明确申明扩展的访问级别，给改扩展内所有成员申明一个新的默认访问级别。

//如果扩展了某个协议，那么就不能对该扩展使用访问级别修饰符来申明。


/**
 *  范型
 */
//范型类型或范型函数的访问级别取决于范型类型，函数本身，范型类型参数 三者中最低访问级别。


/**
 *  类型别民
 */
//任何定义的类型别名都会被当作不同的类型，以便于进行访问控制。
//一个类型别名的访问级别不可高于原类型的访问级别。






































































































