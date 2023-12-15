//
//  CGFloat+.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

/*
CGFloat.infinity  - 表示正无穷大;
CGFloat.greatestFiniteMagnitude - 最大的有限正浮点数; 最大的非无穷大数值;
CGFloat.leastNormalMagnitude - 最小的正规浮点数;
CGFloat.leastNonzeroMagnitude - 表示最小的非零正浮点数;
 
 CGFloat.infinity >
 CGFloat.greatestFiniteMagnitude >
 CGFloat.leastNormalMagnitude >
 CGFloat.leastNonzeroMagnitude 是大于0的最小正浮点数。
 
*/


/// CGFloat.nan
/// - CGFloat.nan 是静默 NaN，不会触发异常

/// CGFloat.signalingNaN
/// - CGFloat.signalingNaN 是信号 NaN，会触发浮点异常。

// MARK: - 通用扩展
public extension CGFloat {
    
    /// 分辨率
    var pixel: CGFloat {
        return 1 / UIScreen.main.scale
    }
    
    /// 按照精度规则取值
    /// - Parameters:
    ///   - rule: 规则
    ///   - precision: 小数精度
    /// - Returns: 结果
    func rounded(_ rule: FloatingPointRoundingRule, precision: Int) -> CGFloat {
        return (self * CGFloat(precision)).rounded(rule) / CGFloat(precision)
    }
    
}

// MARK: - 兼容协议
extension CGFloat: HHCompatible {}

public extension HHElement where Element == CGFloat {
    
    var float: Float { Float(element) }
    
    var int: Int { Int(element)  }
    
    var double: Double { Double(element) }
    
    /// 弧度 => 角度
    func radianToDegree() -> CGFloat {
        return element / CGFloat.pi * 180
    }

    /// 角度 => 弧度
    func degreeToRadian() -> CGFloat {
        return element / 180 * CGFloat.pi
    }
}
