//
//  EmarsysInboxDetailController.swift
//  InboxSample
//
//  Created by Bianca Lui on 23/6/2020.
//  Copyright © 2020 Emarsys. All rights reserved.
//

import UIKit
import EmarsysSDK

class EmarsysInboxDetailController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var initialIndex = 0
    var messages: [EMSMessage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = EmarsysInboxConfig.bodyBackgroundColor
    }
    
}

extension EmarsysInboxDetailController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EmarsysInboxDetailCollectionViewCell.id, for: indexPath) as! EmarsysInboxDetailCollectionViewCell
        
        cell.titleLabel.textColor = EmarsysInboxConfig.bodyForegroundColor
        
        guard indexPath.row < messages?.count ?? 0, let message = messages?[indexPath.row] else { return cell }
        cell.titleLabel.text = message.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
}
