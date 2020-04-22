//
//  StoriesViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit
import SkeletonView

class StoriesViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: Public Properties
    var output: StoriesViewOutput!

    // MARK: Private Properties
    private var refreshControl = UIRefreshControl()
    private var theme: Theme?

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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Metrics.estimatedRowHeight
        tableView.isSkeletonable = true
        tableView.prefetchDataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshStories(_:)), for: .valueChanged)
        
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    private func configureSkeleton() {
        let gradient = SkeletonGradient(baseColor: .gray)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        view.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        view.isSkeletonable = true
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
        configureSkeleton()
    }
    
    func hideAnimatedSkeleton() {
        view.hideSkeleton()
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
extension StoriesViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return StoryTableViewCell.reuseIdentifier
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StoryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let model = output.getModel(for: indexPath.row)

        if let theme = theme {
            cell.apply(theme: theme)
        }
        
        cell.hideSkeleton()
        cell.setup(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: ThemeUpdatable
extension StoriesViewController: ThemeUpdatable {
    func update(theme: Theme) {
        self.theme = theme
        theme.tableView.apply(to: tableView)
        theme.view.apply(to: view)
        tableView.visibleCells.forEach { ($0 as? StoryTableViewCell)?.apply(theme: theme) }
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
