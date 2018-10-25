//
//  CommentsViewController.swift
//  HackerNews
//
//  Created by Никита Васильев on 22/10/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit
import NetworkManager

class CommentsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var commentsIds: [Int]?
    
    private var comments = [Item]()
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        configure()
        loadComments(ids: commentsIds)
    }

    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.startAnimating()
    }
    
    fileprivate func style() {
        tableView.backgroundColor = Color.tableBackground
        tableView.separatorColor = Color.tableSeparator
    }
    
    fileprivate func configure() {
        title = "Comments"
        tableView.register(CommentTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateComments(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching New Comments...",
                                                            attributes: [.foregroundColor: UIColor.white])
        tableView.backgroundView = activityIndicator
    }
    
    @objc private func updateComments(_ sender: Any) {
        loadComments(ids: commentsIds)
    }
    
    fileprivate func loadComments(ids: [Int]?) {
        guard let ids = ids else { return }
        NetworkManager.shared.retrieve(ids: ids) { [weak self] (response) in
            switch response {
            case .success(let comments):
                self?.comments = comments
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
                self?.activityIndicator.stopAnimating()
            case .error(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
}

extension CommentsViewController: UITableViewDelegate { }

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.comment = comments[indexPath.row]
        return cell
    }
}
