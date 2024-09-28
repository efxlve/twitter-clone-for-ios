//
//  NotificationsController.swift
//  Twitter Clone
//
//  Created by Muharrem Efe Çayırbahçe on 8/25/24.
//

import UIKit

private let reuseIdentifier = "NotificationCell"

class NotificationsController: UITableViewController {
    
    // MARK: - Properties
    
    private var notifications = [Notification]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchNotifications()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        configureUI()
    }
    
    // MARK: - API
    
    func fetchNotifications() {
        NotificationService.shared.fetchNotifications { notifications in
            self.notifications = notifications
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Notifications"
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = .systemBackground
        let titleColor: UIColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
        
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension NotificationsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        return cell
    }
}
