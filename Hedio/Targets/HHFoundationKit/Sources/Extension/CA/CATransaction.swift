//
//  CATransaction.swift
//  Hedio
//
//  Created by whh on 2023/8/2.
//

import Foundation

extension CATransaction {
    
    class func withDisabledActions<T> (_ body: () throws -> T) rethrows -> T {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        // defer 中的语句，会在body()执行完后才执行
        defer {
            CATransaction.commit()
        }
        return try body()
    }
    
}
