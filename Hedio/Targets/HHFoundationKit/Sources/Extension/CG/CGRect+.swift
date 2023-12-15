//
//  CGRect.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

// MARK: - 通用扩展
extension CGRect {
    
    
}

// MARK: - 兼容协议
extension CGRect: HHCompatible { }

// MARK: - 兼容协议 - 加密（crypto）
public extension HHElement where Element == CGRect {
    
    /// 是否含有NaN数值.
    var isNaN: Bool {
        return [element.origin.x, element.origin.y, element.width, element.height].contains(where: { $0.isNaN })
    }
    
    /// 转化为bounds
    var bounds: CGRect { CGRect(origin: .zero, size: element.size) }
    
    
    
}
