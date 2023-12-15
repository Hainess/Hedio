//
//  Value+Formatter.swift
//  Hedio
//
//  Created by whh on 2023/8/7.
//

import Foundation

public extension HHElement where Element == Double {
    
    /// 传入小数点，转为百分比格式; 遵循四舍五入；
    /// 例如：传入 0.454，转成 46%； 传入 0.433，转成 43%；
    func toPercentWithSymbol(locale: Locale, withoutWhitespaces: Bool = true) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.locale = locale
        let formattedPercentage = formatter.string(from: NSNumber(value: element))
        print(formattedPercentage ?? "")
        if withoutWhitespaces {
            return formattedPercentage?
                .replacingOccurrences(of: " ", with: "") /// 俄语专属空格，特殊符号
                .replacingOccurrences(of: " ", with: "")
        } else {
            return formattedPercentage
        }
    }
    
}

