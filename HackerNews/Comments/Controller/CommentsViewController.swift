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
    
    private var comments: [Comment] = []
 
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
        if commentsIds != nil {
            tableView.refreshControl = refreshControl
            tableView.backgroundView = activityIndicator
        }
        tableView.register(CommentTableViewCell.self)
        tableView.tableFooterView = UIView()
        refreshControl.addTarget(self, action: #selector(updateComments(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching New Comments...",
                                                            attributes: [.foregroundColor: UIColor.white])
        view.backgroundColor = Color.appBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    @objc private func updateComments(_ sender: Any) {
        loadComments(ids: commentsIds)
    }
    
    // swiftlint:disable force_cast
    fileprivate func loadComments(ids: [Int]?) {
        guard let ids = ids else { return }
        NetworkManager.shared.getComments(ids: ids) { (response) in
            switch response {
            case .success(let comments):
                var flattenedCommnets = [Any]()
                
                for comment in comments {
                    flattenedCommnets += comment.flattenedComments() as! [Any]
                }
                
                self.comments = flattenedCommnets.compactMap { $0 } as! [Comment]

                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    // swiftlint:enable force_cast
}

extension CommentsViewController: UITableViewDelegate { }

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let comment = comments[indexPath.row]
        
        cell.comment = comment
        
        cell.usernameLeadingConstraint.constant = CGFloat(9 + comment.level * 20)
        cell.timeLeadingConstraint.constant = CGFloat(9 + comment.level * 20)
        cell.commentLeadingConstraint.constant = CGFloat(20 + comment.level * 20)
        
        cell.selectionStyle = .none
        
        return cell
    }
}
