//
//  HHPropertyWrapper.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

/*
 @用户存储包装器
 eg: @HHUserDefault("xxx", defaultValue: xxx)
     static var key: Bool
 */
@propertyWrapper
public struct HHUserDefault<T> {
    public var key: String
    public var defaultValue: T?
    public var wrappedValue: T? {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    public init(_ key: String, defaultValue: T? = nil) {
        self.key = key
        self.defaultValue = defaultValue
    }
}


/*
 @区间包装器
 eg: @HHClamping(min: 0, max: 255) var red: Int = 127
 */
@propertyWrapper
public struct HHClamping<V: Comparable> {
    public var value: V
    public let min: V
    public let max: V
    public init(wrappedValue: V, min: V, max: V) {
        value = wrappedValue
        self.min = min
        self.max = max
        assert(value >= min && value <= max)
    }
    public var wrappedValue: V {
        get { return value }
        set {
            if newValue < min {
                value = min
            } else if newValue > max {
                value = max
            } else {
                value = newValue
            }
        }
    }
}


/*
 @深拷贝包装器
 eg: @HHCopying var data: Array = []
 */
@propertyWrapper
public struct HHCopying<Value: NSCopying> {
    private var _value: Value
    public init(wrappedValue value: Value) {
        self._value = value.copy() as! Value
    }
    public var wrappedValue: Value {
        get { return _value }
        set { _value = newValue.copy() as! Value }
    }
}

