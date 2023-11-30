import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains Hedio App target and Hedio unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: "Hedio",
                          platform: .iOS,
                          additionalTargets: ["HedioKit",
                                              "HedioUI",
                                              "HHWeb2PDFKit"])


struct UI {
    
}

struct HHTarget {
    
    private struct C {
        static let platform: Platform = .iOS
        static let organize = "com.lilivi."
    }
    
    private struct Kit {
        static let Foundation = "HHFoundationKit"
        static let UI = "HHUIKit"
        static let Network = "HHNetworkKit"
        static let File = "HHFileKit"
        static let GL = "HHGLKit"
        static let Keychain = "HHKeychainKit"
        static let Beta = "HHBetaKit"
        static let Notification = "HHNotificationKit"
        static let Share = "HHShareKit"
        static let Queue = "HHQueueKit"
        static let Album = "HHAlbumKit"
        static let Crypto = "HHCryptoKit"
        static let RouteKit = "HHRouteKit"
        static let Localize = "HHLocalizeKit"
    }

    private static func make(name: String,
                             dependencies: [TargetDependency] = []) -> Target {
        return Target(name: name,
                      platform: C.platform,
                      product: .framework,
                      bundleId: C.organize + name,
                      dependencies: dependencies)
    }
    
}

extension HHTarget {
    
    static let Foundation = make(name: Kit.Foundation)
    static let UI = make(name: Kit.UI)
    static let Network = make(name: Kit.Network)
    static let Keychain = make(name: Kit.Keychain)
    static let Beta = make(name: Kit.Beta)
    static let File = make(name: Kit.File)
    
}
