//
//  StoriesViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: Public Properties
    var output: StoriesViewOutput!

    // MARK: Private Properties
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
}

// MARK: UITableViewDelegate
extension StoriesViewController: UITableViewDelegate {
    
}

// MARK: UITableViewDataSource
extension StoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = output.getModel(for: indexPath.row)
        
        let cell: StoryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setup(model: model)
        
        if let theme = theme {
            cell.apply(theme: theme)
        }
        
        return cell
    }
}

// MARK: ThemeUpdatable
extension StoriesViewController: ThemeUpdatable {
    func update(theme: Theme) {
        self.theme = theme
        theme.tableView.apply(to: tableView)
        theme.view.apply(to: view)
        tableView.reloadData()
    }
}
