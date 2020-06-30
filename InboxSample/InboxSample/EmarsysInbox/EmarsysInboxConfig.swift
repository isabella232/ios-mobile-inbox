//
//  EmarsysInboxConfig.swift
//  InboxSample
//
//  Created by Bianca Lui on 23/6/2020.
//  Copyright © 2020 Emarsys. All rights reserved.
//

import UIKit

struct EmarsysInboxConfig {
    
    public static var headerBackgroundColor: UIColor? = .color(fromHexCode: 0x5F9F9FFF)
    public static var headerForegroundColor: UIColor? = .white
    public static var bodyBackgroundColor: UIColor? = .color(fromHexCode: 0xD1EEEEFF)
    public static var bodyForegroundColor: UIColor? = .black
    public static var bodyTintColor: UIColor? = .systemBlue
    public static var bodyHighlightTintColor: UIColor? = .color(fromHexCode: 0xFFD700FF)
    public static var activityIndicatorColor: UIColor? = .darkGray
    public static var favImageOff: UIImage? = UIImage(systemName: "star") // todo change to image support <ios13
    public static var favImageOn: UIImage? = UIImage(systemName: "star.fill")
    
}
