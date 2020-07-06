//
//  Copyright © 2020 Emarsys. All rights reserved.
//

import UIKit
import EmarsysSDK

public class EmarsysInboxController: UIViewController {
    
    public static func new() -> UIViewController {
        return UIStoryboard.init(name: "EmarsysInbox", bundle: Bundle(for: self))
            .instantiateViewController(withIdentifier: "EmarsysInboxController")
    }
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var messages: [EMSMessage]?
    var isFetchingMessages = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.backgroundColor = EmarsysInboxConfig.headerBackgroundColor
        headerLabel.textColor = EmarsysInboxConfig.headerForegroundColor
        tableView.backgroundColor = EmarsysInboxConfig.bodyBackgroundColor
        refreshControl.tintColor = EmarsysInboxConfig.activityIndicatorColor?.withAlphaComponent(0.5)
        activityIndicatorView.color = EmarsysInboxConfig.activityIndicatorColor
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(fetchMessages), for: .valueChanged)
        
        fetchMessages()
    }
    
    @objc func fetchMessages() {
        guard !isFetchingMessages else { return }
        isFetchingMessages = true
        Emarsys.messageInbox.fetchMessages { [weak self] (result, error) in
            self?.activityIndicatorView.stopAnimating()
            self?.refreshControl.endRefreshing()
            self?.messages = result?.messages.filter({ !($0.tags?.contains(EmarsysInboxTag.deleted) ?? false) })
            self?.isFetchingMessages = false
            self?.tableView.reloadData()
        }
    }
    
}

extension EmarsysInboxController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row < messages?.count ?? 0, let message = messages?[indexPath.row],
            !(message.tags?.contains(EmarsysInboxTag.seen) ?? false) else { return }
//        Emarsys.messageInbox.addTag(EmarsysInboxTag.seen, forMessage: message.id) { [weak self] (error) in
            message.tags?.append(EmarsysInboxTag.seen)
//        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: EmarsysInboxTableViewCell.id, for: indexPath) as! EmarsysInboxTableViewCell
        
        if cell.favImageView?.gestureRecognizers?.isEmpty ?? true {
            cell.favImageView?.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(favImageViewClicked)))
        }
        
        cell.titleLabel.textColor = EmarsysInboxConfig.bodyForegroundColor
        cell.datetimeLabel.textColor = EmarsysInboxConfig.bodyForegroundColor
        
        guard indexPath.row < messages?.count ?? 0, let message = messages?[indexPath.row] else { return cell }
        cell.favImageView?.image = message.tags?.contains(EmarsysInboxTag.pinned) ?? false ?
            EmarsysInboxConfig.favImageOn : EmarsysInboxConfig.favImageOff
        cell.favImageView?.tintColor = message.tags?.contains(EmarsysInboxTag.pinned) ?? false ?
            EmarsysInboxConfig.bodyHighlightTintColor : EmarsysInboxConfig.bodyTintColor
        
        cell.titleLabel.text = message.title
        cell.datetimeLabel.text = DateFormatter.yyyyMMddHHmm
            .string(from: Date(timeIntervalSince1970: TimeInterval(truncating: message.receivedAt)))
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard indexPath.row < messages?.count ?? 0, let message = messages?[indexPath.row] else { return }
        if editingStyle == .delete {
            Emarsys.messageInbox.addTag(EmarsysInboxTag.deleted, forMessage: message.id)
            messages?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension EmarsysInboxController {
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EmarsysInboxDetailController,
            let tableViewCell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: tableViewCell) {
            destination.initialIndexPath = indexPath
            destination.messages = messages
        }
    }
    
    @objc func favImageViewClicked(_ sender: UIGestureRecognizer) {
        guard let cell = sender.view?.superview?.superview as? EmarsysInboxTableViewCell,
            let indexPath = tableView.indexPath(for: cell),
            indexPath.row < messages?.count ?? 0, let message = messages?[indexPath.row] else { return }
        if let pinnedIndex = message.tags?.firstIndex(of: EmarsysInboxTag.pinned) {
            message.tags?.remove(at: pinnedIndex)
//            Emarsys.messageInbox.removeTag(EmarsysInboxTag.pinned, fromMessage: message.id) { [weak self] (error) in
//            }
        } else {
            message.tags?.append(EmarsysInboxTag.pinned)
//            Emarsys.messageInbox.addTag(EmarsysInboxTag.pinned, forMessage: message.id) { [weak self] (error) in
//            }
        }
        tableView.reloadData()
    }
    
}
