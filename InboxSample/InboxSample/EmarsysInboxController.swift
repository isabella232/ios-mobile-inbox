//
//  EmarsysInboxController.swift
//  InboxSample
//
//  Created by Bianca Lui on 17/6/2020.
//  Copyright © 2020 Emarsys. All rights reserved.
//

import UIKit
import EmarsysSDK

class EmarsysInboxController: UIViewController {
    
    static func new() -> UIViewController {
        return UIStoryboard.init(name: "EmarsysInbox", bundle: nil)
            .instantiateViewController(withIdentifier: "EmarsysInboxController")
    }
    
    public var headerBackgroundColor: UIColor? = .defaultHeaderBackgroundColor
    public var headerForegroundColor: UIColor? = .defaultHeaderForegroundColor
    public var tableViewBackgroundColor: UIColor? = .defaultTableViewBackgroundColor
    public var tableViewCellTintColor: UIColor? = .defaultTableViewCellTintColor
    public var tableViewCellForegroundColor: UIColor? = .defaultTableViewCellForegroundColor
    public var tableViewCellFavImageOff: UIImage? = UIImage(systemName: "star") // todo change to image support <ios13
    public var tableViewCellFavImageOn: UIImage? = UIImage(systemName: "star.fill")
    public var activityIndicatorColor: UIColor? = .defaultActivityIndicatorColor
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var messages: [EMSMessage]?
    var isFetchingMessages = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.backgroundColor = headerBackgroundColor
        headerLabel.textColor = headerForegroundColor
        tableView.backgroundColor = tableViewBackgroundColor
        refreshControl.tintColor = activityIndicatorColor?.withAlphaComponent(0.5)
        activityIndicatorView.color = activityIndicatorColor
        
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
            self?.messages = result?.messages
            self?.isFetchingMessages = false
            self?.tableView.reloadData()
        }
    }
    
}

extension EmarsysInboxController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row < messages?.count ?? 0, let message = messages?[indexPath.row],
            !(message.tags?.contains(EmarsysInboxTag.seen) ?? false) else { return }
//        Emarsys.messageInbox.addTag(EmarsysInboxTag.seen, forMessage: message.id) { [weak self] (error) in
            message.tags?.append(EmarsysInboxTag.seen)
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmarsysInboxTableViewCell.id, for: indexPath) as! EmarsysInboxTableViewCell
        cell.favImageView?.tag = indexPath.row
        if cell.favImageView?.gestureRecognizers?.isEmpty ?? true {
            cell.favImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favImageViewClicked)))
        }
        
        cell.favImageView?.tintColor = tableViewCellTintColor
        cell.titleLabel.textColor = tableViewCellForegroundColor
        cell.datetimeLabel.textColor = tableViewCellForegroundColor
        
        guard indexPath.row < messages?.count ?? 0, let message = messages?[indexPath.row] else { return cell }
        cell.favImageView?.image = message.tags?.contains(EmarsysInboxTag.pinned) ?? false ?
            tableViewCellFavImageOn : tableViewCellFavImageOff
        cell.titleLabel.text = message.title
        cell.datetimeLabel.text = DateFormatter.yyyyMMddHHmm
            .string(from: Date(timeIntervalSince1970: TimeInterval(truncating: message.receivedAt)))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

extension EmarsysInboxController {
    
    @objc func favImageViewClicked(_ sender: UIGestureRecognizer) {
        guard let index = sender.view?.tag, index < messages?.count ?? 0, let message = messages?[index] else { return }
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
