//
//  CALayer+.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

extension CALayer: HHCompatible { }

// MARK: - 字典&JSON
extension HHElement where Element: CALayer {
    
    /// 设置寄宿图片
    /// - Parameters:
    ///   - imageNamed: 图片名称
    ///   - contentsGravity: 缩放方式
    func attach(_ image: UIImage?, _ gravity: CALayerContentsGravity) {
        element.contents = image?.cgImage
        element.contentsGravity = gravity
        element.contentsScale = image?.scale ?? UIScreen.main.scale
    }
    
}
