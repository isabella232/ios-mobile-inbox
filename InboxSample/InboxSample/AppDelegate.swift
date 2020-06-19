//
//  Copyright © 2019 Emarsys. All rights reserved.
//

import UIKit
import EmarsysSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = EMSConfig.make { builder in
            builder.setMobileEngageApplicationCode("EMS89-AACEA")
            builder.setContactFieldId(100010824)
        }
        Emarsys.setup(with: config)
        
        return true
    }
}

