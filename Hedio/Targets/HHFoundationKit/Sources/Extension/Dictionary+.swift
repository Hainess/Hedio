//
//  Dictionary+.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

extension Dictionary {

    /// 字典拼接(如果拼接的其他字典有相同`KEY`会覆盖当前的值)
    /// - Parameter other: 另外一个字典
    mutating func append<T>(_ other: T) where T: Sequence, T.Iterator.Element == (key: Key, value: Value) {
        for (k ,v) in other {
            self[k] = v
        }
    }
    
}
    
extension Dictionary: HHCompatible { }

// MARK: - 字典&JSON
extension HHElement where Element == Dictionary<String, Any> {
    
    /// 将字典转换为JSON字符串
    public func toJSONString(prettyPrint: Bool = false) -> String? {
        let `self` = element
        return Self.toJSONString(self, prettyPrint: prettyPrint)
    }
    
    /// 将Object转换为JSON字符串
    private static func toJSONString(_ JSONObject: Any, prettyPrint: Bool) -> String? {
        let options: JSONSerialization.WritingOptions = prettyPrint ? .prettyPrinted : []
        if let JSON = Self.toJSONData(JSONObject, options: options) {
            return String(data: JSON, encoding: String.Encoding.utf8)
        }
        
        return nil
    }
    
    /// 将Object转换为JSON数据
    private static func toJSONData(_ JSONObject: Any, options: JSONSerialization.WritingOptions) -> Data? {
        if JSONSerialization.isValidJSONObject(JSONObject) {
            let JSONData: Data?
            do {
                JSONData = try JSONSerialization.data(withJSONObject: JSONObject, options: options)
            } catch let error {
                print(error)
                JSONData = nil
            }
            
            return JSONData
        }
        
        return nil
    }
    
}
