//
//  PostViewerViewController.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 23/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class PostViewerViewController: UIViewController {
    var output: PostViewerViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

extension PostViewerViewController: PostViewerViewInput {
    func setupInitialState() {
        
    }
}