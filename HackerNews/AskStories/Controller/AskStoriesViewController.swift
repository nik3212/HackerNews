//
//  AskStoriesViewController.swift
//  HackerNews
//
//  Created by Никита Васильев on 06/10/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit
import NetworkManager
import SafariServices

class AskStoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var stories = [Item]()
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        configure()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.startAnimating()
    }
    
    fileprivate func style() {
        tableView.backgroundColor = Color.tableBackground
        tableView.separatorColor = Color.tableSeparator
    }
    
    fileprivate func configure() {
        tableView.register(NewsTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateAskStories(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Ask Stories...",
                                                            attributes: [.foregroundColor: UIColor.white])
        tableView.backgroundView = activityIndicator
    }
    
    fileprivate func loadData() {
        NetworkManager.shared.retrieve(type: .ask) { [weak self] (response) in
            switch response {
            case .success(let stories):
                self?.stories = stories
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
                self?.activityIndicator.stopAnimating()
            case .error(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    @objc private func updateAskStories(_ sender: Any) {
        loadData()
    }
}

extension AskStoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = stories[indexPath.row]
        if let url = item.url {
            let webViewController = SFSafariViewController(url: URL(string: url)!)
            webViewController.delegate = self
            present(webViewController, animated: true)
        }
    }
}

extension AskStoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.story = stories[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension AskStoriesViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension AskStoriesViewController: NewsCellDelegate {
    func newsCellDidSelectComment(cell: NewsTableViewCell, storyId: Int) {
        
    }
}
