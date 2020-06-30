//
//  CommentsViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: Public Properties
    var output: CommentsViewOutput!

    // MARK: Private Properties
    private var theme: Theme?
    private var activityIndicator = UIActivityIndicatorView()
    
    private lazy var loadingFooterView: UIView = {
        let view = UIView()
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .black
        view.addSubview(activityIndicator)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureActivityIndicator()
        output.viewIsReady()
        self.navigationItem.leftItemsSupplementBackButton = true
    }
    
    // MARK: Private Methods
    private func setup() {
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        tableView.register(PostTableViewCell.self)
        tableView.register(SkeletonCell.self)
        tableView.register(CommentCell.self)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        if #available(iOS 11.0, *) {
            tableView.estimatedRowHeight = UITableView.automaticDimension
        } else {
            tableView.estimatedRowHeight = Metrics.estimatedRowHeight
        }
    }
    
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.style = .gray
        activityIndicator.hidesWhenStopped = true
    }
    
    private func showLoadingIndicator() {
        let spinner = UIActivityIndicatorView(style: .gray)
        theme?.activityIndicator.apply(to: spinner)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
    
    private func hideLoadingIndicator() {
        tableView.tableFooterView = nil
    }
}

// MARK: CommentsViewInput
extension CommentsViewController: CommentsViewInput {
    func setupInitialState(title: String) {
        self.title = title
    }
    
    func displayMessage(text: String) {
        let backgroundView = UIView()
        let textLabel = UILabel()
        
        textLabel.attributedText = theme?.noCommentsText(text: text)
        
        view.setView(textLabel)
        
        tableView.backgroundView = backgroundView
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func insertRows(at indexPaths: [IndexPath]) {
        tableView.beginUpdates()
        self.tableView.setContentOffset(self.tableView.contentOffset, animated: false)
        tableView.insertRows(at: indexPaths, with: .automatic)
        tableView.endUpdates()
    }
    
    func setLoadingIndicator(to state: Bool) {
        state ? showLoadingIndicator() : hideLoadingIndicator()
    }
}

// MARK: UITableViewDelegte
extension CommentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDataSource
extension CommentsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.numbersOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = output.getModel(for: indexPath)
        return tableView.dequeueReusableCell(forIndexPath: indexPath, with: model)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        output.willDisplay(for: indexPath)
    }
}

// MARK: ThemeUpdatable
extension CommentsViewController: ThemeUpdatable {
    func update(theme: Theme) {
        self.theme = theme
        
        if let navigationBar = navigationController?.navigationBar {
            theme.navigationBar.apply(to: navigationBar)
        }
        
        theme.activityIndicator.apply(to: activityIndicator)
        theme.tableView.apply(to: tableView)
        theme.view.apply(to: view)
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows ?? [], with: .none)
    }
}

// MARK: Constants
extension CommentsViewController {
    private enum Metrics {
        static let estimatedRowHeight: CGFloat = 75.0
    }
}
