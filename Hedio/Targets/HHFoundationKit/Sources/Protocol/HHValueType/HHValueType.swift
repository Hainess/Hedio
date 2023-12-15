//
//  HHValueType.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

// MARK: - 数值类型
public typealias HHValueType = Numeric & Comparable

// MARK: - 数值类型的计算协议
protocol HHValueComputable: HHValueType {
    
    func clamp(_ a: Self, _ b: Self) -> Self
    
}

extension HHValueComputable {

    /// 比对矫正当前值
    /// - Parameters:
    ///   - a: 最小值
    ///   - b: 最大值
    /// - Returns: 矫正过的数值
    func clamped(_ a: Self, _ b: Self) -> Self {
        let minValue = a <= b ? a : b
        let maxValue = a <= b ? b : a
        return max(min(self, maxValue), minValue)
    }

}

extension Comparable {
    
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }

}
