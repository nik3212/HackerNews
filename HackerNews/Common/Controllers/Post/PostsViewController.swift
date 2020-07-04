//
//  PostsViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

final class PostsViewController: UITableViewController {
    
    // MARK: Public Properties
    var output: PostsViewOutput!

    // MARK: Private Properties
    private var segmentedControl = UISegmentedControl()
    private var theme: Theme?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        output.viewIsReady()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        segmentedControl.setNeedsLayout()
        segmentedControl.layoutIfNeeded()
    }

    // MARK: Private Methods
    private func setup() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .always
        }
        
        navigationController?.navigationBar.isAccessibilityElement = true
        navigationController?.navigationBar.accessibilityIdentifier = "storiesNavigationBar"
        
        tableView.register(PostTableViewCell.self)
        tableView.register(SkeletonCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Metrics.estimatedRowHeight
        tableView.refreshControl = UIRefreshControl()
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.refreshControl?.addTarget(self, action: #selector(refreshStories(_:)), for: .valueChanged)
    
        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = [.top, .left, .right]
    }

    private func configureNavigationItem(with titles: [String]) {
        for (index, title) in titles.enumerated() {
            segmentedControl.insertSegment(withTitle: title, at: index, animated: false)
        }
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.sizeToFit()
        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange(_:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
    
    // MARK: Private Methods
    private func showLoadingIndicator() {
        let spinner = UIActivityIndicatorView(style: .gray)
        theme?.activityIndicator.apply(to: spinner)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
    
    private func hideLoadingIndicator() {
        tableView.tableFooterView = UIView()
    }
}

// MARK: StoriesViewInput
extension PostsViewController: PostsViewInput {    
    func setupInitialState(title: String, theme: Theme, titles: [String]?) {
        self.title = title
        self.theme = theme
        update(theme: theme)
        
        if let titles = titles {
            configureNavigationItem(with: titles)
        }
    }

    func reloadData() {
        tableView.reloadData()
    }
    
    func setScrollEnabled(to state: Bool) {
        tableView.isScrollEnabled = state
    }

    func hideRefreshControl() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func setUserInteractorEnabled(to state: Bool) {
        tableView.isUserInteractionEnabled = state
    }
    
    func scrollContentToTop() {
        if #available(iOS 11.0, *) {
            tableView.setContentOffset(CGPoint(x: 0,
                                               y: -tableView.adjustedContentInset.top),
                                       animated: false)
        } else {
            tableView.setContentOffset(CGPoint(x: 0,
                                               y: -tableView.contentInset.top),
                                       animated: false)
        }
    }
    
    func setLoadingIndicator(to state: Bool) {
        state ? showLoadingIndicator() : hideLoadingIndicator()
    }
}

// MARK: UITableViewDataSourcePrefetching
extension PostsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            output.prefetch(at: indexPath)
        }
    }
}

// MARK: UITableViewDelegate
extension PostsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDataSource
extension PostsViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? SkeletonCell {
            cell.slide(to: .right)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = output.getModel(for: indexPath)
        return tableView.dequeueReusableCell(forIndexPath: indexPath, with: model)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: EmptyDataSetSource
extension PostsViewController: EmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return theme?.emptySetTitle(title: output.getEmptyDataSetTitle())
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return theme?.emptySetDescription(text: output.getEmptyDataSetDecription())
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return output.getEmptyDataSetImage().resource
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return Metrics.verticalOffset
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}

// MARK: EmptyDataSetDelegate
extension PostsViewController: EmptyDataSetDelegate {

}

extension PostsViewController: PostTableViewCellDelegate {
    func imageDidTapped(cell: PostTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        output.didSelectImage(at: indexPath.row)
    }
}

// MARK: ThemeUpdatable
extension PostsViewController: ThemeUpdatable {
    func update(theme: Theme) {
        self.theme = theme
        theme.tableView.apply(to: tableView)
        theme.view.apply(to: view)
        theme.segmentedControl.apply(to: segmentedControl)
        
        if let refreshControl = tableView.refreshControl {
            theme.refreshControl.apply(to: refreshControl)
        }
        
        if let indexPaths = tableView.indexPathsForVisibleRows, !indexPaths.isEmpty {
            tableView.reloadRows(at: indexPaths, with: .none)
        }
    }
}

// MARK: Constants
extension PostsViewController {
    private enum Metrics {
        static let estimatedRowHeight: CGFloat = 75.0
        static let verticalOffset: CGFloat = -50.0
    }
}

// MARK: Selectors
extension PostsViewController {
    @objc func refreshStories(_ sender: UIRefreshControl) {
        output.refreshStories()
    }
    
    @objc func segmentedControlDidChange(_ sender: UISegmentedControl) {
        output.segmentedControlDidChange(to: sender.selectedSegmentIndex)
    }
}
