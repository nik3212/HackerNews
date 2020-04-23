//
//  StoriesViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class StoriesViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: Public Properties
    var output: StoriesViewOutput!

    // MARK: Private Properties
    private var refreshControl = UIRefreshControl()
    private var theme: Theme?
    private var showSkeleton: Bool = false
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        output.viewIsReady()
    }
    
    // MARK: Private Methods
    private func setup() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        tableView.register(StoryTableViewCell.self)
        tableView.register(SkeletonCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Metrics.estimatedRowHeight
        tableView.prefetchDataSource = self
        tableView.refreshControl = refreshControl
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        refreshControl.addTarget(self, action: #selector(refreshStories(_:)), for: .valueChanged)
        
        self.extendedLayoutIncludesOpaqueBars = true
    }
}

// MARK: StoriesViewInput
extension StoriesViewController: StoriesViewInput {
    func setupInitialState(theme: Theme) {
        self.theme = theme
        update(theme: theme)
    }
    
    func changeNavigationTitle(with title: String) {
        self.title = title
    }
    
    func reloadData() {
        tableView.reloadData()
    }

    func showAnimatedSkeleton() {
        showSkeleton = true
    }
    
    func hideAnimatedSkeleton() {
        showSkeleton = false
    }
    
    func hideRefreshControl() {
        tableView.refreshControl?.endRefreshing()
    }
}

// MARK: UITableViewDataSourcePrefetching
extension StoriesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            output.prefetch(at: indexPath)
        }
    }
}

// MARK: UITableViewDelegate
extension StoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDataSource
extension StoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? SkeletonCell {
            cell.slide(to: .right)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showSkeleton {
            let cell: SkeletonCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if let theme = theme { cell.apply(theme: theme) }
            return cell
        }
        
        let cell: StoryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let model = output.getModel(for: indexPath.row)

        print("\(indexPath.row)")
        print(output.getModel(for: indexPath.row))
        
        if let theme = theme { cell.apply(theme: theme) }

        cell.setup(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: EmptyDataSetSource
extension StoriesViewController: EmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return nil
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return nil
    }
}

// MARK: EmptyDataSetDelegate
extension StoriesViewController: EmptyDataSetDelegate {
    
}

// MARK: ThemeUpdatable
extension StoriesViewController: ThemeUpdatable {
    func update(theme: Theme) {
        self.theme = theme
        theme.tableView.apply(to: tableView)
        theme.view.apply(to: view)
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows ?? [], with: .none)
    }
}

// MARK: Constants
extension StoriesViewController {
    private enum Metrics {
        static let estimatedRowHeight: CGFloat = 75.0
    }
}

// MARK: Selectors
extension StoriesViewController {
    @objc func refreshStories(_ sender: UIRefreshControl) {
        output.refreshStories()
    }
}
