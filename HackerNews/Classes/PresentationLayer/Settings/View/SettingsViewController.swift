//
//  SettingsViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: Constants
    enum SettingsConstants {
        static let defaultCellHeight: CGFloat = 48.0
    }
    
    // MARK: IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: Public Properties
    var output: SettingsViewOutput!

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        setup()
        output.viewIsReady()
    }
    
    // MARK: Private Methods
    private func setup() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        tableView.register(SettingsTableViewCell.self)
        tableView.rowHeight = SettingsConstants.defaultCellHeight
    }
}

// MARK: SettingsViewInput
extension SettingsViewController: SettingsViewInput {
    func setupInitialState() {
        
    }
}

// MARK: UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRow(at: indexPath)
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
        
        //let cell = UITableViewCell()
        //cell.textLabel?.text = model.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingsConstants.defaultCellHeight
    }
}
