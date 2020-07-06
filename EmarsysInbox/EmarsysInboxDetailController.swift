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
//        Emarsys.messageInbox.addTag(EmarsysInboxTag.opened, forMessage: message.id) { [weak self] (error) in
            message.tags?.append(EmarsysInboxTag.opened)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EmarsysInboxDetailCollectionViewCell.id, for: indexPath) as! EmarsysInboxDetailCollectionViewCell
        
        cell.titleLabel.textColor = EmarsysInboxConfig.bodyForegroundColor
        cell.datetimeLabel.textColor = EmarsysInboxConfig.bodyForegroundColor
        cell.bodyLabel.textColor = EmarsysInboxConfig.bodyForegroundColor
        
        cell.imageView.image = nil
        cell.imageViewAspectRatio.constant = 0
        cell.imageUrl = nil
        
        guard indexPath.row < messages?.count ?? 0, let message = messages?[indexPath.row] else { return cell }
        cell.titleLabel.text = message.title
        cell.datetimeLabel.text = DateFormatter.yyyyMMddHHmm
            .string(from: Date(timeIntervalSince1970: TimeInterval(truncating: message.receivedAt)))
        cell.bodyLabel.text = message.body
        
        guard let imageUrl = message.imageUrl, let url = URL(string: imageUrl) else { return cell }
        cell.imageUrl = imageUrl
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200, error == nil,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async() {
                guard cell.imageUrl == imageUrl else { return }
                cell.imageView.image = image
                cell.imageViewAspectRatio.constant = image.size.height / image.size.width * cell.imageView.bounds.width
            }
        }.resume()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
}
