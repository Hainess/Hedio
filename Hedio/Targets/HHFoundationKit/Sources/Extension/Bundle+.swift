//
//  Bundle+.swift
//  HHFoundationKit
//
//  Created by whh on 2023/8/1.
//

import Foundation

// MARK: - 通用扩展
extension Bundle {
    
    /// 根据类(模块所在类)生成模块的`Bundle`
    /// - Parameters:
    ///   - name: 模块`Bundle`名称
    ///   - aClass: finder类，用于定位Bundle所在模块
    /// - Returns: 对应模块的bundle
    static func generate(_ name: String, finder aClass: AnyClass) -> Bundle {
        let bundleName = name
        
        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,
            
            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: aClass).resourceURL,
            
            // For command-line tools.
            Bundle.main.bundleURL,
        ]
        
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        
        return Bundle(for: aClass)
    }
    
}

// MARK: - 兼容协议
extension Bundle: HHCompatible { }

// MARK: - 兼容协议 - 加密（crypto）
public extension HHElement where Element: Bundle {
    
    
}
