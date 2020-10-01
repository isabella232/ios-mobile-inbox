//
//  Copyright © 2020 Emarsys. All rights reserved.
//

import UIKit

public class EmarsysInboxConfig {
    
    public static var headerBackgroundColor: UIColor? = .color(fromHexCode: 0x5F9F9FFF)
    public static var headerForegroundColor: UIColor? = .white
    public static var bodyBackgroundColor: UIColor? = .color(fromHexCode: 0xD1EEEEFF)
    public static var bodyForegroundColor: UIColor? = .black
    public static var bodyTintColor: UIColor? = .systemBlue
    public static var bodyHighlightTintColor: UIColor? = .color(fromHexCode: 0xFFD700FF)
    public static var activityIndicatorColor: UIColor? = .darkGray
    public static var favImageOff: UIImage? = UIImage(named: "star", in: Bundle(for: EmarsysInboxConfig.self), compatibleWith: nil)
    public static var favImageOn: UIImage? = UIImage(named: "star.fill", in: Bundle(for: EmarsysInboxConfig.self), compatibleWith: nil)
    public static var favViewBackgroundColor: UIColor? = .color(fromHexCode: 0x5F9F9FFF)
    public static var defaultImage: UIImage? = UIImage(named: "emarsys", in: Bundle(for: EmarsysInboxConfig.self), compatibleWith: nil)
    public static var highPriorityImage: UIImage? = UIImage(named: "exclamationmark", in: Bundle(for: EmarsysInboxConfig.self), compatibleWith: nil)
    
}
