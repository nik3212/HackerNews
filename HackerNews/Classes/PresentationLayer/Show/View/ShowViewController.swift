//
//  ShowViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

final class ShowViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: Public Properties
    var output: ShowViewOutput!

    // MARK: Private Properties
    private var refreshControl = UIRefreshControl()
    private var theme: Theme?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        output.viewIsReady()
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
extension ShowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDataSource
extension ShowViewController: UITableViewDataSource {
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
extension ShowViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            output.prefetch(at: indexPath)
        }
    }
}

// MARK: EmptyDataSetSource
extension ShowViewController: EmptyDataSetSource {
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
}

// MARK: ShowViewInput
extension ShowViewController: ShowViewInput {
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
extension ShowViewController: ThemeUpdatable {
    func update(theme: Theme) {
        self.theme = theme
        theme.view.apply(to: view)
        theme.refreshControl.apply(to: refreshControl)
        theme.tableView.apply(to: tableView)
    }
}

// MARK: Constants
extension ShowViewController {
    private enum Metrics {
        static let estimatedRowHeight: CGFloat = 75.0
        static let verticalOffset: CGFloat = -50.0
    }
}

// MARK: Selectors
extension ShowViewController {
    @objc func refreshStories(_ sender: UIRefreshControl) {
        output.refreshStories()
    }
}
