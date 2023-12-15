//
//  Bundle+Info.swift
//  Hedio
//
//  Created by lilivi on 2023/8/6.
//

import Foundation

public struct APPINFO {
    
    private typealias K = KEY
    private struct KEY {
        static let version = "CFBundleShortVersionString"
        static let build = "CFBundleVersion"
        static let bundleDisplayName = "CFBundleDisplayName"
        static let bundleID = "MainAppBundleIdentifier"
        static let launch_storyboardName = "UILaunchStoryboardName"
        static let launch_images = "UILaunchImages"
        static let AppStoreURL = "AppStoreURL"
    }
   
    static let shared = APPINFO()
    
}

extension APPINFO {

    /// APP 构建号
    public var build: String? {
        Bundle.main.infoDictionary?[K.build] as? String
    }
    
    /// APP 版本号(短)
    public var version: String? {
        Bundle.main.infoDictionary?[K.version] as? String
    }
    
    /// APP 版本号(版本+构建)
    public var appversion: String? {
        guard let version else { return nil }
        guard let build else { return version }
        return version + build
    }
    
    /// APP 显示名称
    public var displayName: String? {
        Bundle.main.infoDictionary?[K.bundleDisplayName] as? String
    }
    
    /// APP `bundle Identifier`
    public var bundleId: String? {
        Bundle.main.bundleIdentifier
    }
    
}

extension APPINFO {
    
    /// 获取 `info.plist` 文件中的某个key对应的value
    public func value<T>(for key: String) -> T? {
        Bundle.main.infoDictionary?[key] as? T
    }
    
}
