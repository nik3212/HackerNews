//
//  AskViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

final class AskViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: Public Properties
    var output: AskViewOutput!

    // MARK: Private Properties
    private var refreshControl = UIRefreshControl()
    private var theme: Theme?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        output.viewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows ?? [], with: .none)
    }
    
    // MARK: Private Methods
    private func setup() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .always
        }
        
        tableView.register(StoryTableViewCell.self)
        tableView.register(SkeletonCell.self)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Metrics.estimatedRowHeight
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshStories(_:)), for: .valueChanged)
        
        tableView.emptyDataSetSource = self
        
        extendedLayoutIncludesOpaqueBars = true
    }
}

// MARK: UITableViewDelegate
extension AskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDataSource
extension AskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? SkeletonCell {
            cell.slide(to: .right)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = output.getModel(for: indexPath)
        return tableView.dequeueReusableCell(forIndexPath: indexPath, with: model)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getNumberOfRow()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: UITableViewDataSourcePrefetching
extension AskViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            output.prefetch(at: indexPath)
        }
    }
}

// MARK: EmptyDataSetSource
extension AskViewController: EmptyDataSetSource {
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

// MARK: AskViewInput
extension AskViewController: AskViewInput {
    func setupInitialState(title: String, theme: Theme) {
        self.title = title
        self.theme = theme
    }
    
    func setUserInteractorEnabled(to state: Bool) {
        tableView.isUserInteractionEnabled = state
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func hideRefreshControl() {
        tableView.refreshControl?.endRefreshing()
    }
}

// MARK: ThemeUpdatable
extension AskViewController: ThemeUpdatable {
    func update(theme: Theme) {
        self.theme = theme
        theme.view.apply(to: view)
        theme.refreshControl.apply(to: refreshControl)
        theme.tableView.apply(to: tableView)
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows ?? [], with: .none)
    }
}

// MARK: Constants
extension AskViewController {
    private enum Metrics {
        static let estimatedRowHeight: CGFloat = 75.0
        static let verticalOffset: CGFloat = -50.0
    }
}

// MARK: Selectors
extension AskViewController {
    @objc func refreshStories(_ sender: UIRefreshControl) {
        output.refreshStories()
    }
}
