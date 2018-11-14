//
//  ShowStoriesViewController.swift
//  HackerNews
//
//  Created by Никита Васильев on 06/10/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit
import NetworkManager
import SafariServices

class ShowStoriesViewController: UIViewController {

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
        refreshControl.addTarget(self, action: #selector(updateShowStories(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Show Stories...",
                                                            attributes: [.foregroundColor: UIColor.white])
        tableView.backgroundView = activityIndicator
    }
    
    private func loadMoreStories() {
        dataSource.fetchingMore = true
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        tableView.endUpdates()
        loadData()
    }
    
    private func loadData() {
        StoriesLoader.retrieve(to: dataSource, type: .show) { [weak self] (error) in
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
    
    @objc private func updateShowStories(_ sender: Any) {
        dataSource.ids.removeAll()
        dataSource.stories.removeAll()
        tableView.reloadData()
        loadData()
    }
}

extension ShowStoriesViewController: UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = dataSource.stories[indexPath.row]
        if let url = item.url {
            let webViewController = SFSafariViewController(url: URL(string: url)!)
            webViewController.delegate = self
            present(webViewController, animated: true)
        }
    }
}

extension ShowStoriesViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ShowStoriesViewController: StoriesListDelegate {
    func openCommentView(cell: NewsTableViewCell, storyId: Int) {
        let commentsController = ViewControllerFactory.instantiate(.Comments) as CommentsViewController
        commentsController.commentsIds = cell.story.kids
        commentsController.articleTitle = cell.story.title
        navigationController?.pushViewController(commentsController, animated: true)
    }
}
