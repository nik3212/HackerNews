//
//  PostsViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class PostsViewController: UIViewController {
    
    // MARK: Public Properties
    var output: PostsViewOutput!

    // MARK: Private Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var refreshControl = UIRefreshControl()
    private var segmentedControl = UISegmentedControl()
    private var theme: Theme?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        createSubviews()
        output.viewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows ?? [], with: .none)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.invalidateIntrinsicContentSize()
    }
    
    // MARK: Private Methods
    private func setup() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .never
        }
        
        navigationController?.navigationBar.isAccessibilityElement = true
        navigationController?.navigationBar.accessibilityIdentifier = "storiesNavigationBar"
        
        tableView.register(PostTableViewCell.self)
        tableView.register(SkeletonCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Metrics.estimatedRowHeight
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        refreshControl.addTarget(self, action: #selector(refreshStories(_:)), for: .valueChanged)
    
        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = [.top, .left, .right]
    }
    
    private func createSubviews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            safeTrailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            safeBottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        segmentedControl.setNeedsLayout()
        segmentedControl.layoutIfNeeded()
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
        tableView.tableFooterView = nil
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
extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDataSource
extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? SkeletonCell {
            cell.slide(to: .right)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = output.getModel(for: indexPath)
        return tableView.dequeueReusableCell(forIndexPath: indexPath, with: model)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
        theme.refreshControl.apply(to: refreshControl)
        theme.segmentedControl.apply(to: segmentedControl)
        
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
