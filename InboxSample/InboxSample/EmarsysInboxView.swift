//
//  EmarsysInboxView.swift
//  InboxSample
//
//  Created by Bianca Lui on 16/6/2020.
//  Copyright © 2020 Emarsys. All rights reserved.
//

import UIKit

@IBDesignable public class EmarsysInboxView: UIView {
    
    @IBInspectable public var headerBackgroundColor: UIColor? = .cyan {
      didSet { backgroundColor = headerBackgroundColor }
    }
    
    @IBInspectable var borderWidth: CGFloat = 3 {
       didSet {
           layer.borderWidth = borderWidth
       }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        headerBackgroundColor = .cyan
        borderWidth = 3
        let v = UIView()
        v.backgroundColor = .red
        v.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        addSubview(v)
    }
    
}
