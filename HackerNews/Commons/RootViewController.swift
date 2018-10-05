//
//  RootViewController.swift
//  HackerNews
//
//  Created by Никита Васильев on 05/10/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        configure()
    }
    
    fileprivate func style() {
        navigationController?.navigationBar.barStyle = UIBarStyle.default
        navigationController?.navigationBar.barTintColor = Color.navigationBarBackground
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.navigationControllerText]
        tabBarController?.tabBar.barTintColor = Color.tabBarBackground
        tabBarController?.tabBar.tintColor = Color.appTint
        view.backgroundColor = Color.appBackground
    }
    
    fileprivate func configure() {
        let topStoriesController = ViewControllerFactory.instantiate(.TopStories) as TopStoriesViewController
        topStoriesController.tabBarItem = UITabBarItem(title: "Top", image: nil, tag: 0)
        let newsStoriesController = ViewControllerFactory.instantiate(.NewsStories) as NewsStoriesViewController
        newsStoriesController.tabBarItem = UITabBarItem(title: "New", image: nil, tag: 1)
        let askStoriesController = ViewControllerFactory.instantiate(.AskStories) as AskStoriesViewController
        askStoriesController.tabBarItem = UITabBarItem(title: "Ask", image: nil, tag: 2)
        let showStoriesController = ViewControllerFactory.instantiate(.ShowStories) as ShowStoriesViewController
        showStoriesController.tabBarItem = UITabBarItem(title: "Show", image: nil, tag: 3)
        tabBarController?.viewControllers = [topStoriesController, newsStoriesController, askStoriesController, showStoriesController]
    }
}
