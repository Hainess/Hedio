//
//  URL+.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation

extension URL: HHCompatible { }

public extension HHElement where Element == URL {
    
    /// 从URL中解析参数
    var queryParameters: [String: String]? {
        let `self` = element
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else { return nil }

        var items: [String: String] = [:]

        for queryItem in queryItems {
            items[queryItem.name] = queryItem.value
        }

        return items
    }

    /// 通过 `Host` 与 `参数` 合并成get类型的URL链接
    static func combination(host: String, params: [String: Any]) -> String {
        var link = host
        var parameters = params
        guard params.isEmpty == false else { return link }

        if host.contains("?"), let url = URL(string: host) {
            link = String(host.split(separator: "?").first ?? "")
            if let queryParams = url.hh.queryParameters {
                parameters.append(queryParams)
            }
        }

        link.append("?")
        let values = parameters.compactMap({ "\($0.key)=\($0.value)" })
        return link + values.joined(separator: "&")
    }

}
