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
        
        NetworkManager.shared.retrieve(ids: [18052121, 18051762, 18045741, 18049515, 18051264, 18051037, 18052221, 18051809, 18051171, 18050873, 18034852, 18034004, 18052243, 18049512, 18039833, 18049509, 18050090, 18050838, 18051990, 18051338, 18045583, 18052331, 18049795, 18051161, 18050585, 18045318, 18048316, 18048744, 18051067, 18051417]) { (snap) in
            switch snap {
            case .success(let data):
                print("\(data[0].title)")
            case .error(let error):
                print("\(error)")
            }
        }
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
