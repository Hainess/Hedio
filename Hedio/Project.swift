import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin
import Foundation

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
let project = HHTarget.app(name: HHTarget.App.Hedio.rawValue,
                           frameworks: [])
