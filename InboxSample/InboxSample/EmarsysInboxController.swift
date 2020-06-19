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
    
    public var headerBackgroundColor: UIColor? = .defaultHeaderBackgroundColor {
        didSet { headerView.backgroundColor = headerBackgroundColor }
    }
    
    public var headerForegroundColor: UIColor? = .defaultHeaderForegroundColor {
        didSet { headerLabel.textColor = headerForegroundColor }
    }
    
    public var tableViewBackgroundColor: UIColor? = .defaultTableViewBackgroundColor {
        didSet { tableView.backgroundColor = tableViewBackgroundColor }
    }
    
    public var tableViewCellTintColor: UIColor? = .defaultTableViewCellTintColor
    public var tableViewCellForegroundColor: UIColor? = .defaultTableViewCellForegroundColor
    public var tableViewCellFavImageOff: UIImage? //= UIImage(systemName: "star")
    public var tableViewCellFavImageOn: UIImage? //= UIImage(systemName: "star.fill")
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    var messages: [EMSMessage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.backgroundColor = headerBackgroundColor
        headerLabel.textColor = headerForegroundColor
        tableView.backgroundColor = tableViewBackgroundColor
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        fetchMessages()
    }
    
    func fetchMessages() {
        Emarsys.messageInbox.fetchMessages { [weak self] (result, error) in
            self?.refreshControl.endRefreshing()
            for message in result?.messages ?? [] {
                print(message.title)
            }
            self?.messages = result?.messages
            self?.tableView.reloadData()
        }
    }
    
    @objc func refresh() {
        fetchMessages()
    }
    
}

extension EmarsysInboxController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmarsysInboxTableViewCell", for: indexPath) as! EmarsysInboxTableViewCell
        cell.favImageView?.tintColor = tableViewCellTintColor
        cell.titleLabel.textColor = tableViewCellForegroundColor
        cell.datetimeLabel.textColor = tableViewCellForegroundColor
        guard indexPath.row < messages?.count ?? 0, let message = messages?[indexPath.row] else { return cell }
        cell.titleLabel.text = message.title
        cell.datetimeLabel.text = "\(message.receivedAt)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}
