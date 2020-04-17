//
//  SettingsViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {
        
    // MARK: IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: Public Properties
    var output: SettingsViewOutput!
    var theme: Theme!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update(theme: theme)
        tableView.tableFooterView = UIView()
        output.viewIsReady()
    }

    // MARK: Private Methods
    private func setup() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .never
        }
        
        tableView.register(SettingsTableViewCell.self)
        update(theme: theme)
    }
}

// MARK: SettingsViewInput
extension SettingsViewController: SettingsViewInput {
    func setupInitialState(title: String) {
        self.title = title
    }
}

// MARK: UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return output.getTitleForHeader(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getNumberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let model = output.getModel(for: indexPath)
        cell.setup(model: model)
        cell.apply(theme: theme)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metric.cellHeight
    }
}

// MARK: ThemeUpdatable
extension SettingsViewController: ThemeUpdatable {
    func update(theme: Theme) {
        self.theme = theme
        theme.tableView.apply(to: tableView)
        theme.view.apply(to: view)
        tableView.reloadData()
    }
}

// MARK: Constants
extension SettingsViewController {
    private enum Metric {
       static let cellHeight: CGFloat = 48.0
    }
}
