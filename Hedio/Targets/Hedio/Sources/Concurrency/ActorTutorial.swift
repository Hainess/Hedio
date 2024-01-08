//
//  ActorTutorial.swift
//  Hedio
//
//  Created by lilivi on 2024/1/6.
//  Copyright © 2024 com.lilivi. All rights reserved.
//

import Foundation

/// 之前解决数据竞争，通常使用锁队列，保证同步访问，确保一次只有一个线程访问了该变量。或者在异步线程使用锁。
/// Concurrency 并发框架引入了用于同步数据访问的 Actor, 比调度队列更直接,更易懂。


class HHStickerService1 {
    
    /// 读写对象
    private var stickers: [String] = []
    /// 安全队列
    private let queue = DispatchQueue(label: "name.lock.queue")
    
    /// 写入
    func update(_ value: String) {
        DispatchQueue.global().async {
            self.queue.async {
                self.stickers.append(value)
            }
        }
    }
    
    /// 读取
    func fetch(completion: (String?) -> Void) {
        var value: String?
        self.queue.async {
            value = self.stickers.last
            DispatchQueue.main.async {
                completion(value)
            }
        }
    }
    
    /// 测试
    static func demo() async {
        let service = HHStickerService1()
        service.update("sticker")
        service.fetch {
            print($0 ?? "")
        }
    }
    
}


actor HHStickerService2 {
    
    /// 读写对象
    private var stickers: [String] = []
   
    /// 写入
    func update(_ value: String) {
        self.stickers.append(value)
    }
    
    /// 读取
    func fetch() -> String? {
        return self.stickers.last
    }
    
    /// 测试
    static func demo() async {
        let service2 = HHStickerService2()
        let value = await service2.fetch()
        print(value ?? "")
    }

    
    /// 优化 - 多线程并发，防止不必要的暂停
    
}

/// 隔离（isolated）与  非隔离(nonisolated)访问

