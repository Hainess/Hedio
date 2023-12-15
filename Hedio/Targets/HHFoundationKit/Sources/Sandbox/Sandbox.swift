//
//  Sandbox.swift
//  HHFoundationKit
//
//  Created by whh on 2023/8/1.
//

import Foundation

/// 沙盒文件处理相关
struct Sandbox {
    
    struct Home {
        static let document: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    
}
