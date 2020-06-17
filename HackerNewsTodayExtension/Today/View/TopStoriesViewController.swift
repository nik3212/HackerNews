//
//  TopStoriesViewController.swift
//  HackerNewsTodayExtension
//
//  Created by Никита Васильев on 17.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit
import NotificationCenter

final class TopStoriesViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        confiure()
    }
    
    // MARK: Private Methods
    private func confiure() {
        tableView.register(UINib(nibName: TopStoryTableViewCell.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: TopStoryTableViewCell.cellIdentifier)
        tableView.isScrollEnabled = false
    }
}

// MARK: NCWidgetProviding
extension TopStoriesViewController: NCWidgetProviding {
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            self.preferredContentSize = maxSize
        } else if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize(width: maxSize.width, height: Metrics.expandedHeight)
        }
    }
}

// MARK: UITableViewDelegate
extension TopStoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: UITableViewDataSource
extension TopStoriesViewController: UITableViewDataSource {
    // swiftlint:disable force_cast
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopStoryTableViewCell.cellIdentifier, for: indexPath) as! TopStoryTableViewCell
        cell.setup(title: "Test", url: "Test", rate: "123")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metrics.cellHeight
    }
}

// MARK: Metrics
extension TopStoriesViewController {
    private enum Metrics {
        static let cellHeight: CGFloat = 56.0
        static let expandedHeight: CGFloat = 448.0
    }
}
