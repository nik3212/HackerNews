//
//  ViewController.swift
//  HackerNews
//
//  Created by Никита Васильев on 24/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(NewsTableCell.self)
        tableView.tableFooterView = UIView()
        style()
    }
    
    fileprivate func style() {
        view.backgroundColor = Color.appBackground
        tableView.backgroundColor = Color.tableBackground
        tableView.separatorColor = Color.tableSeparator
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
