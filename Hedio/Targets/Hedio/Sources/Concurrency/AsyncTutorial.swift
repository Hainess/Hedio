//
//  AsyncTutorial.swift
//  Hedio
//
//  Created by lilivi on 2024/1/6.
//  Copyright © 2024 com.lilivi. All rights reserved.
//

import Foundation

class AsyncTutorial {
    
    
    
    
}

// MARK: - 闭包转async
extension AsyncTutorial {
    
    @available(*, renamed: "request()")
    private func request(completion: @escaping (Bool) -> Void) {
        Task {
            let result = await request()
            completion(result)
        }
    }
    
    
    private func request() async -> Bool {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                continuation.resume(returning: true)
            }
        }
    }
    
    /// Xcode 点击函数名，Refactor提供三个便利转换
    /// - 1. Convert Function to Async
    private func request1() async -> Bool {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                continuation.resume(returning: true)
            }
        }
    }
    
    /// Add Async Alternative
    
    /// Xcode 点击函数名，Refactor提供三个便利转换 - 装饰器包装
    /// 3. Add Async Wrpper
    @available(*, renamed: "request3()")
    private func request3(completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {
            completion(true)
        }
    }
    private func request3() async -> Bool {
        return await withCheckedContinuation { continuation in
            request3() { result in
                continuation.resume(returning: result)
            }
        }
    }
    
}

// MARK: -
extension AsyncTutorial {
    
}
