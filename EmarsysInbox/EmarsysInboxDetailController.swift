//
//  Copyright © 2020 Emarsys. All rights reserved.
//

import UIKit
import EmarsysSDK

class EmarsysInboxDetailController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var initialized = false
    var initialIndexPath: IndexPath?
    var messages: [EMSMessage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = EmarsysInboxConfig.bodyBackgroundColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard !initialized, let ip = initialIndexPath else { return }
        initialized = true
        collectionView.scrollToItem(at: ip, at: .left, animated: false)
    }
    
}

extension EmarsysInboxDetailController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row < messages?.count ?? 0, let message = messages?[indexPath.row],
            !(message.tags?.contains(EmarsysInboxTag.opened) ?? false) else { return }
        message.tags?.append(EmarsysInboxTag.opened)
        Emarsys.messageInbox.addTag(EmarsysInboxTag.opened, forMessage: message.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EmarsysInboxDetailCollectionViewCell.id, for: indexPath) as! EmarsysInboxDetailCollectionViewCell
        
        cell.titleLabel.textColor = EmarsysInboxConfig.bodyForegroundColor
        cell.datetimeLabel.textColor = EmarsysInboxConfig.bodyForegroundColor
        cell.bodyLabel.textColor = EmarsysInboxConfig.bodyForegroundColor
        
        cell.imageView.image = nil
//        cell.imageViewAspectRatio.constant = 0
        cell.imageUrl = nil
        
        guard indexPath.row < messages?.count ?? 0, let message = messages?[indexPath.row] else { return cell }
        cell.titleLabel.text = message.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:MM - dd MMM YYY"
        dateFormatter.locale = Locale.current
        let date = Date(timeIntervalSince1970: TimeInterval(truncating: message.receivedAt))
        let formattedDate = dateFormatter.string(from: date)
        
        cell.datetimeLabel.text = formattedDate
        cell.bodyLabel.text = message.body
        
        guard let imageUrl = message.imageUrl, let url = URL(string: imageUrl) else {
            cell.imageView.image = EmarsysInboxConfig.defaultImage
            return cell
        }
        cell.imageUrl = imageUrl
        cell.imageView.downloaded(from: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom))
    }
    
}
