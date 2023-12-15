//
//  HHCompatible.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

/// 兼容协议，避免命名空间与使用问题
public protocol HHCompatible {
    associatedtype CompatibleType
    var hh: CompatibleType { get }
}

public extension HHCompatible {
    var hh: HHElement<Self> {
        return HHElement(self)
    }
}

/// 兼容协议桥接对象
public struct HHElement<Element> {
    let element: Element
    init(_ element: Element) {
        self.element = element
    }
}
