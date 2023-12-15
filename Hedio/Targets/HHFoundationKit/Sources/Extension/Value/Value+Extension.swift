//
//  Value+Extension.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

// MARK: - Float
extension Float: HHCompatible {}

public extension HHElement where Element == Float {
    
    var double: Double { Double(element) }
    
    var int: Int { Int(element)  }
    
    var cgFloat: CGFloat { CGFloat(element) }
    
    var string: String { String(element) }
    
}

// MARK: - Double
extension Double: HHCompatible {}

public extension HHElement where Element == Double {
    
    var float: Float { Float(element) }
    
    var int: Int { Int(element)  }
    
    var cgFloat: CGFloat { CGFloat(element) }
    
    var string: String { String(element) }
    
}

// MARK: - Int
extension Int: HHCompatible {}

public extension HHElement where Element == Int {
    
    var float: Float { Float(element) }
    
    var double: Double { Double(element)  }
    
    var cgFloat: CGFloat { CGFloat(element) }
    
    var string: String { String(element) }
 
    var bool: Bool { element != 0 }
    
    /// 视频时间格式化
    /// - Parameter time: 需要格式化的时间
    /// - Returns: 格式化后的时间
    func timeFormat() -> String {
        let `self` = element
        if self < 3600 {
            return String(format: "%02d:%02d", self / 60, self % 60)
        } else {
            return String(format: "%d:%02d:%02d", self / 3600, self % 3600 / 60, self % 60)
        }
    }
    
}

// MARK: - String
// extension String: HHCompatible {}

public extension HHElement where Element == String {
    
    var float: Float { Float(element) ?? 0 }
    
    var double: Double { Double(element) ?? 0  }
    
    var cgFloat: CGFloat { CGFloat(double) }
    
}


// MARK: - Bool
extension Bool: HHCompatible {}

public extension HHElement where Element == Bool {
    
    var int: Float { element ? 1 : 0 }
    
}
