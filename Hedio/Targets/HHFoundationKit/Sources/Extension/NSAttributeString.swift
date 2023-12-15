//
//  NSAttributeString.swift
//  HHFoundationKit
//
//  Created by whh on 2023/8/1.
//

import Foundation

// MARK: - 通用扩展
extension NSAttributedString {
    
    /// 给富文本增减间距
    /// - Parameter width: 间距宽
    /// - Returns: 间距富文本
    static func hh_spacing(_ width: CGFloat) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.bounds = CGRect(origin: .zero, size: CGSize(width: width, height: 0))
        return NSAttributedString(attachment: attachment)
    }
    
}

// MARK: - 兼容协议
extension NSAttributedString: HHCompatible { }

// MARK: - 兼容协议 - 本地化
public extension HHElement where Element: NSAttributedString {
    
}
