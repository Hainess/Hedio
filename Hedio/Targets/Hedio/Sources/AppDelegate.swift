import UIKit
import HedioKit
import HedioUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        HedioKit.hello()
        HedioUI.hello()
        
        /// 秒数转倒计时格式
        for value in [10, 100, 3660, 10000, 100000, 1000000, 10000000] {
            print("value: \(value.countdown())")
        }
        
        return true
    }

}

extension Int {
    
    func countdown() -> String {
        let seconds = self
        return String(format: "%02d:%02d:%02d",
                      seconds / 3600,
                      seconds % 3600 / 60,
                      seconds % 60)
    }
    
}

