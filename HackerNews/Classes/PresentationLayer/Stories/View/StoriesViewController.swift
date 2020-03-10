//
//  StoriesViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {
    var output: StoriesViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

extension StoriesViewController: StoriesViewInput {
    func setupInitialState() {
        
    }
}
