//
//  ViewController.swift
//  HackerNews
//
//  Created by Никита Васильев on 24/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit
import MXSegmentedControl
import NetworkManager

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: MXSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(NewsTableCell.self)
        tableView.tableFooterView = UIView()
        style()
        configure()
    }
    
    fileprivate func style() {
        UIApplication.shared.statusBarView?.backgroundColor = Color.segmentedControlBackground
        
        view.backgroundColor = Color.appBackground
        tableView.backgroundColor = Color.tableBackground
        tableView.separatorColor = Color.tableSeparator
        
        segmentedControl.backgroundColor = Color.segmentedControlBackground
        segmentedControl.font = Font.segmentedControl
        segmentedControl.textColor = Color.segmentedControlText
        segmentedControl.selectedTextColor = Color.segmentedControlSelect
        segmentedControl.indicatorColor = Color.segmentedControlSelect
        segmentedControl.indicatorHeight = 2.0
    }
    
    fileprivate func configure() {
        segmentedControl.append(title: "Top")
        segmentedControl.append(title: "Newest")
        segmentedControl.append(title: "Ask HN")
    }
}

extension NewsViewController: UITableViewDelegate {}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
}
