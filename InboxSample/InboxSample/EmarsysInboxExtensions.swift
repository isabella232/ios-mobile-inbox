//
//  EmarsysInboxExtensions.swift
//  InboxSample
//
//  Created by Bianca Lui on 17/6/2020.
//  Copyright © 2020 Emarsys. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let defaultHeaderBackgroundColor = color(fromHexCode: 0x5F9F9FFF)
    static let defaultHeaderForegroundColor = white
    static let defaultTableViewBackgroundColor = color(fromHexCode: 0xD1EEEEFF)
    static let defaultTableViewCellForegroundColor = black
    static let defaultTableViewCellTintColor = systemBlue
    
    static func color(fromHexCode hex: UInt64) -> UIColor {
        let r = ((CGFloat)((hex & 0xFF000000) >> 24)) / 255.0
        let g = ((CGFloat)((hex & 0x00FF0000) >> 16)) / 255.0
        let b = ((CGFloat)((hex & 0x0000FF00) >> 8)) / 255.0
        let a = ((CGFloat)((hex & 0x000000FF) >> 0)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
}

extension DateFormatter {
    
    static let yyyyMMddHHmm: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        return df
    }()
    
}
