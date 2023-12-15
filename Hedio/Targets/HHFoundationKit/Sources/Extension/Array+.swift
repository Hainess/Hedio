//
//  Array+.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

// MARK: - 数组扩展
extension Array {

    /// 安全获取数组数据的下标
    /// 使用:   items[safe: 10]
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
    /// 安全添加元素
    mutating func append(safe element: Element?) {
        guard let m = element else { return }
        append(m)
    }
    
    /// 安全调用 "removeLast()" 方法
    @discardableResult
    mutating func hh_removeLast() -> Element? {
        guard isEmpty == false else { return nil }
        return removeLast()
    }

    /// 安全调用 "removeFirst()" 方法
    @discardableResult
    mutating func hh_removeFirst() -> Element? {
        guard isEmpty == false else { return nil }
        return removeFirst()
    }

    mutating func hh_remove(at index: Int) {
        guard index < count else { return }
        remove(at: index)
    }

}

public extension Array where Element: Equatable {

    /// 数组去重
    mutating func hh_removeDuplicates() {
        var result: [Element] = []
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
    
    /// 删除元素; 数组中有多个一样的元素，只会移除第一个;
    mutating func hh_remove(_ element: Element) -> Bool {
        guard let index = firstIndex(of: element) else { return false }
        remove(at: index)
        return true
    }

    /// 深度比对. 数据里的对象必须实现Equatable
    func hh_elementsEqualTo(_ another: Array<Element>) -> Bool {
        if count != another.count { return false }
        if isEmpty { return true }
        for index in 0..<count {
            if self[index] != another[index] {
                return false
            }
        }
        return true
    }
    
}
