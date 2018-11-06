//
//  NewsStoriesViewController.swift
//  HackerNews
//
//  Created by Никита Васильев on 06/10/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit
import SafariServices

class NewsStoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .white)
    
    private var dataSource = StoriesListDataSource()
    
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
        tableView.register(LoadingTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        dataSource.delegate = self
        tableView.dataSource = dataSource
        refreshControl.addTarget(self, action: #selector(updateNewStories(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching New Stories...",
                                                            attributes: [.foregroundColor: UIColor.white])
        tableView.backgroundView = activityIndicator
    }
    
    @objc private func updateNewStories(_ sender: Any) {
        dataSource.ids.removeAll()
        dataSource.stories.removeAll()
        tableView.reloadData()
        loadData()
    }
    
    private func loadMoreStories() {
        dataSource.fetchingMore = true
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        tableView.endUpdates()
        loadData()
    }
    
    private func loadData() {
        StoriesLoader.retrieve(to: dataSource, type: .news) { [weak self] (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
                self?.activityIndicator.stopAnimating()
                self?.dataSource.fetchingMore = false
            }
        }
    }
}

extension NewsStoriesViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !dataSource.fetchingMore && dataSource.stories.count != dataSource.ids.count &&
                dataSource.stories.count != 0 {
                loadMoreStories()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension NewsStoriesViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension NewsStoriesViewController: StoriesListDelegate {
    func openCommentView(cell: NewsTableViewCell, storyId: Int) {
        let commentsController = ViewControllerFactory.instantiate(.Comments) as CommentsViewController
        commentsController.commentsIds = cell.story.kids
        navigationController?.pushViewController(commentsController, animated: true)
    }
}
