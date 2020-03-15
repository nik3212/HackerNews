//
//  StoriesViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {
    
    // MARK: Public Properties
    var output: StoriesViewOutput!

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
        }
    }
}

extension StoriesViewController: StoriesViewInput {
    func setupInitialState(title: String) {
        self.title = title
    }
}
