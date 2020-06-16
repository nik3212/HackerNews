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
    //@IBOutlet private var tableView: UITableView!
    
    // MARK: Public Properties
    var output: SettingsViewOutput!
    
    // MARK: Private Properties
    private var theme: Theme?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isAccessibilityElement = true
        tableView.accessibilityIdentifier = "settingsTableView"
        tableView.register(SettingsTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        return tableView
    }()
    
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
            navigationController?.navigationItem.largeTitleDisplayMode = .never
        }
        
        view.accessibilityIdentifier = "settingsView"
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeTopAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            safeTrailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            safeBottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }
}

// MARK: SettingsViewInput
extension SettingsViewController: SettingsViewInput {
    func setupInitialState(title: String, theme: Theme) {
        self.title = title
        self.theme = theme
        update(theme: theme)
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
        guard let model = output.getModel(for: indexPath) else { return UITableViewCell() }
        
        let cell: SettingsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setup(model: model)
        cell.isAccessibilityElement = true
        cell.accessibilityIdentifier = String(format: "sTCV_%d_%d", indexPath.section, indexPath.row)

        if let theme = theme {
            cell.apply(theme: theme)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metric.cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView, let textLabel = headerView.textLabel {
            theme?.tableViewHeader.apply(to: headerView)
            theme?.baseTableViewHeaderTitle.apply(to: textLabel)
        }
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
