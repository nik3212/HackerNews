//
//  TopStoriesViewController.swift
//  HackerNewsTodayExtension
//
//  Created by Никита Васильев on 17.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit
import NotificationCenter
import HNService

final class TopStoriesViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: Private Properties
    private var service = HNService()
    private var posts: [PostModel] = []
    
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
    
    private func openLink(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        extensionContext?.open(url, completionHandler: nil)
    }
}

// MARK: NCWidgetProviding
extension TopStoriesViewController: NCWidgetProviding {
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        fetchTopStoriesIds(completionHandler: completionHandler)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            self.preferredContentSize = maxSize
        } else if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize(width: maxSize.width, height: Metrics.expandedHeight)
        }
    }
}

// MARK: Loading Data
extension TopStoriesViewController {
    private func fetchTopStoriesIds(completionHandler: @escaping (NCUpdateResult) -> Void) {
        service.fetchIds(for: .top, completion: { [weak self] ids in
            self?.fetchTopStories(from: Array(ids[0..<Metrics.defaultPostCount]), completionHandler: completionHandler)
        }, fail: { _ in
            completionHandler(.failed)
        })
    }

    private func fetchTopStories(from ids: [Int], completionHandler: @escaping (NCUpdateResult) -> Void) {
        service.loadPosts(with: ids, completion: { [weak self] posts in
            self?.posts = posts
            self?.tableView.reloadData()
            completionHandler(.newData)
        }, fail: { _ in
            completionHandler(.failed)
        })
    }
}

// MARK: UITableViewDelegate
extension TopStoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = posts[indexPath.row].url {
            openLink(from: url)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDataSource
extension TopStoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopStoryTableViewCell.cellIdentifier,
                                                       for: indexPath) as? TopStoryTableViewCell else { return UITableViewCell() }
        let post = posts[indexPath.row]
        cell.setup(model: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
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
        static let defaultPostCount: Int = 8
    }
}
