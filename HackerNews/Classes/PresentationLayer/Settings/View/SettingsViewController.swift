//
//  SettingsViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var output: SettingsViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

extension SettingsViewController: SettingsViewInput {
    func setupInitialState() {
        
    }
}
