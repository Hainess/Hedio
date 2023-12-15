//
//  String+.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

// MARK: - 通用扩展
extension String {
    
    /// 字符串是否为空或者不存在
    /// - Parameter string: 字符串
    public static func isEmpty(_ string: String?) -> Bool {
        guard let string = string else { return true }
        return string.isEmpty
    }
    
}

// MARK: - 兼容协议
extension String: HHCompatible { }

// MARK: - 兼容协议 - 本地化
public extension HHElement where Element == String {
    
    /// 字符串转本地化
    var localized: String {
        return NSLocalizedString(element, comment: "")
    }
    
    /// 首字母大写，其他字母全部小写
    /// - Returns:
    func capitalizeFirstLetter() -> String {
        return element.prefix(1).capitalized + element.lowercased().dropFirst()
    }
    
}


// MARK: - 兼容协议 - size
public extension HHElement where Element == String {
    
    /// 计算字符串的长宽
    /// - Parameters:
    ///   - maxSize: 最大允许的大小
    ///   - attributes: 属性
    /// - Returns: 字符串实际占用的大小
    func boundingSize(with maxSize: CGSize, attributes: [NSAttributedString.Key:Any]?) -> CGSize {
        let str = element as NSString
        let rect = str.boundingRect(with: maxSize, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: attributes, context: nil)
        return rect.size
    }
    
    /// 计算字符串的长度. 适用于允许无限高，有限宽度的情况
    /// - Parameters:
    ///   - maxWidth: 最大允许的宽度
    ///   - attributes: 属性
    /// - Returns: 字符串实际的高度
    func boundingHeight(with maxWidth: CGFloat, attributes: [NSAttributedString.Key:Any]?) -> CGFloat {
        let size = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        return boundingSize(with: size, attributes: attributes).height
    }
    
    /// 计算字符串的长度. 适用于有限高，无限宽度的情况
    /// - Parameters:
    ///   - maxHeight: 最大允许的高度
    ///   - attributes: 属性
    /// - Returns: 字符串实际的宽度
    func boundingWidth(with maxHeight: CGFloat, attributes: [NSAttributedString.Key:Any]?) -> CGFloat {
        let size = CGSize(width: CGFloat.infinity, height: maxHeight)
        return boundingSize(with: size, attributes: attributes).width
    }

    /// 计算字符串高度(限制宽度)
    /// - Parameters:
    ///   - width: 限制宽度
    ///   - font: 固定字体尺寸
    /// - Returns: 高度
    func height(constrained width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = element.boundingRect(with: size,
                                               options: .usesLineFragmentOrigin,
                                               attributes: [NSAttributedString.Key.font: font],
                                               context: nil)
        return boundingBox.height + 1
    }

    /// 计算字符串宽度(限制高度)
    /// - Parameters:
    ///   - width: 限制高度
    ///   - font: 固定字体尺寸
    /// - Returns: 宽度
    func width(constrained height: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = element.boundingRect(with: size,
                                               options: .usesLineFragmentOrigin,
                                               attributes: [NSAttributedString.Key.font: font],
                                               context: nil)
        return boundingBox.width + 1
    }
    
}

// MARK: - 兼容协议 - 加密（crypto）
public extension HHElement where Element == String {
    

    
}
