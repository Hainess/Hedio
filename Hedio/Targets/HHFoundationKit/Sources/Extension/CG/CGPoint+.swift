//
//  CGPoint.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

// MARK: - 通用扩展
extension CGPoint {
    
    
}

// MARK: - 兼容协议
extension CGPoint: HHCompatible { }

// MARK: - 兼容协议 - 加密（crypto）
public extension HHElement where Element == CGPoint {
    
    /// 是否含有NaN数值.
    var isNaN: Bool {
        return [element.x, element.y].contains(where: { $0.isNaN })
    }
    
    /// 以自身为圆心画出等比外框
    /// - Parameter radius: 半径
    func drawGeometricFrame(radius: CGFloat) -> CGRect {
        let x = element.x
        let y = element.y
        let frame: CGRect = .init(x: x - radius,
                                  y: y - radius,
                                  width: radius * 2,
                                  height: radius * 2)
        return frame
    }
    
    /// 旋转公式 - 自身绕圆心旋转后的点坐标
    /// - Parameters:
    ///   - angle: 旋转弧度
    ///   - center: 圆心坐标
    /// - Returns: 旋转后的坐标
    func rotate(angle: CGFloat, center: CGPoint) -> CGPoint {
        let x = element.x
        let y = element.y
        let x_new = (x - center.x) * cos(angle) - (y - center.y) * sin(angle) + center.x
        let y_new = (x - center.x) * sin(angle) + (y - center.y) * cos(angle) + center.y
        return CGPoint(x: x_new, y: y_new)
    }
    
    /// 两点之间直线距离
    func distance(to point: CGPoint) -> CGFloat {
        let dx: CGFloat = element.x - point.x
        let dy: CGFloat = element.y - point.y
        return sqrt(dx * dx + dy * dy)
    }
    
}
