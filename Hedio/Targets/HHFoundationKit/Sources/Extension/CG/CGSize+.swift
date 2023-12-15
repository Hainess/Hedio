//
//  CGSize.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

// MARK: - 通用扩展
extension CGSize {
    
    
}

// MARK: - 兼容协议
extension CGSize: HHCompatible { }

// MARK: - 兼容协议 - 加密（crypto）
public extension HHElement where Element == CGSize {
    
    /// 是否含有NaN数值.
    var isNaN: Bool {
        return [element.width, element.height].contains(where: { $0.isNaN })
    }
    
    /// 取size最大边
    var maxlength: CGFloat { element.width > element.height ? element.width : element.height }

    /// 取size最小边
    var minlength: CGFloat { element.width < element.height ? element.width : element.height }
    
    /// 宽高比
    var ratio: CGFloat { element.width / element.height }

    /// 等比缩放
    /// - Parameter scale: 缩放比例
    /// - Returns: 缩放后的Size
    func scale(_ scale: CGFloat) -> CGSize {
        CGSize(
            width: element.width * scale,
            height: element.height * scale
        )
    }
    
}
