//
//  ThemeViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 27/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet private var tableView: UITableView!
    
    // MARK: Public Properties
    var output: ThemeViewOutput!

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

// MARK: ThemeViewInput
extension ThemeViewController: ThemeViewInput {
    func setupInitialState() {
        
    }
}
