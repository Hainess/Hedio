//
//  HHTarget.swift
//  ProjectDescriptionHelpers
//
//  Created by whh on 2023/12/5.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

struct HHTarget {
    
    struct Framework {
        
    }
    
}

// MARK: - Frameworks
extension HHTarget {
    
    static let foundation = Self.framework(.Foundation, [])
    
    static let ui = Self.framework(.UI, [])
    
    static let network = Self.framework(.Network, [])
    
    static let keychain = Self.framework(.Keychain, [])
    
    static let web2PDF = Self.framework(.Web2PDF, [])
    
    static let File = Self.framework(.File, [])
    
    
}


//case Hedio = "HedioKit"
//case Web2PDF = "HHWeb2PDFKit"


//case File = "HHFileKit"
//case GL = "HHGLKit"
//case Keychain = "HHKeychainKit"
//case Beta = "HHBetaKit"
//case Notification = "HHNotificationKit"
//case Share = "HHShareKit"
//case Queue = "HHQueueKit"
///// case Album = "HHAlbumKit"
//case Crypto = "HHCryptoKit"
//case RouteKit = "HHRouteKit"
//case Localize = "HHLocalizeKit"
