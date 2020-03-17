//
//  SettingsViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
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
    }
}

// MARK: SettingsViewInput
extension SettingsViewController: SettingsViewInput {
    func setupInitialState() {
        
    }
}
