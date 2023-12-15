//
//  HHTarget+.swift
//  ProjectDescriptionHelpers
//
//  Created by whh on 2023/12/5.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - 定义
extension HHTarget {
    
    /// 常量
    fileprivate struct C {
        /// [配置] - 平台
        static let platform: Platform = .iOS
        /// [配置] - 组织
        static let organization = "com.lilivi"
    }
    
    /// 主项目
    enum App: String, CaseIterable {
        case Hedio = "Hedio"
    }
    
    /// UI业务库
    enum UI: String, CaseIterable {
        case Hedio = "HedioUI"
    }
    
    /// 依赖库
    enum Kit: String, CaseIterable {
        case Hedio = "HedioKit"
        case Web2PDF = "HHWeb2PDFKit"
        case Foundation = "HHFoundationKit"
        case UI = "HHUIKit"
        case Network = "HHNetworkKit"
        case File = "HHFileKit"
        case GL = "HHGLKit"
        case Keychain = "HHKeychainKit"
        case Beta = "HHBetaKit"
        case Notification = "HHNotificationKit"
        case Share = "HHShareKit"
        case Queue = "HHQueueKit"
        /// case Album = "HHAlbumKit"
        case Crypto = "HHCryptoKit"
        case RouteKit = "HHRouteKit"
        case Localize = "HHLocalizeKit"
        
        func framework(_ dependencies: [TargetDependency] = []) -> Target {
            HHTarget.framework(self.rawValue, dependencies)
        }
        
    }
    
    
    static func frameworkNames() -> [String] {
        UI.allCases.map { $0.rawValue } +
        Kit.allCases.map { $0.rawValue }
    }
    
}

// MARK: - Make APP
extension HHTarget {
    
    /// 生成 `Project`
    public static func app(name: String,
                           frameworks: [Target]) -> Project {
        
        let infoPlist: [String: Plist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
            ]

        let app = Target(
            name: name,
            platform: C.platform,
            product: .app,
            bundleId: name.bundleId,
            infoPlist: .extendingDefault(with: infoPlist),
            sources: [name.sources],
            resources: [name.resources],
            dependencies: []
        )
        
        let targets = [app] + frameworks
        return Project(name: name,
                       organizationName: C.organization,
                       targets: targets)
    }
    
}

// MARK: - Make Framework
extension HHTarget {
    
    /// 生成 `Framework` target
    static func framework(_ name: String,
                          _ dependencies: [TargetDependency]) -> Target {
        return Target(name: name,
                      platform: C.platform,
                      product: .framework,
                      bundleId: name.bundleId,
                      infoPlist: .default,
                      sources: [name.sources],
                      resources: [name.resources],
                      dependencies: dependencies)
    }
    
    /// 生成 `Framework` target
    static func framework(_ kit: Kit,
                          _ dependencies: [TargetDependency]) -> Target {
        Self.framework(kit.rawValue, dependencies)
    }
    
}

// MARK: - Make Library
extension HHTarget {
    
    /// 生成 `Library` target
    
    
}

// MARK: - Make File
extension HHTarget {
    
    /// 目录检查
    private static func tryMakeFiles(target name: String) {
        let m = FileManager.default
        /// [目录]
        let path = "Targets/\(name)/Sources"
        /// [文件]
        let file = path + "/" + "\(name).swift"
        /// [文件] - 内容
        let content = "// \(name).swift\n"
        do {
            if m.fileExists(atPath: path) == false {
                try m.createDirectory(atPath: path,
                                      withIntermediateDirectories: true,
                                      attributes: nil)
            }
            
            if m.fileExists(atPath: file) == false {
                try content.write(toFile: file,
                                  atomically: true,
                                  encoding: .utf8)
            }
            
        } catch {
            print("❌ERROR: \(error)")
        }
    }
    
}

fileprivate
extension String {
    
    /// [目录] - 源码
    var sources: SourceFileGlob {
        SourceFileGlob(stringLiteral: "Targets/\(self)/Sources/**")
    }
    
    /// [目录] - 素材资源
    var resources: ResourceFileElement {
        ResourceFileElement(stringLiteral: "Targets/\(self)/Resources/**")
    }
    
    /// [包ID]
    var bundleId: String {
        HHTarget.C.organization + "." + self
    }
    
}

