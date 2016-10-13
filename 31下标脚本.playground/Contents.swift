//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  下标语法
 */  //[]
//subscript(index: Int) -> Int {
//    get {
//        //返回与入参匹配的Int类型的值
//    }
//    set {
//        //执行赋值操作
//    }
//}

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
    
    subscript(str: String) -> String {
        return "急急如律令" + str + "显灵"
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("3的6倍是：\(threeTimesTable[6])")
print("出来吧: \(threeTimesTable["包拯"])")

/**
 *  下标脚本选项
 */
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows;
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get{
            assert(indexIsValidForRow(row, column: column), "Index out of range")//断言调试assert(表达式（为假才输出），输出)
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")//断言调试
            grid[(row * columns) + column] = newValue
        }
    }
}

var mattix = Matrix(rows: 2, columns: 2)
print(mattix.grid)
mattix[0, 1] = 1.5
print(mattix.grid)
mattix[1, 0] = 3.2
print(mattix.grid)
//mattix[3,4] = 9//触发了断言











































































































































































































































































