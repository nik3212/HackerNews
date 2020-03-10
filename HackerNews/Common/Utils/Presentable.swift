//
//  Presentable.swift
//  HackerNews
//
//  Created by Никита Васильев on 04.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

protocol Presentable {
    var viewController: UIViewController { get }
    var parent: UIViewController? { get }
    
    func present()
    func presentAsRoot()
    func present(from viewController: UIViewController)
    func presentAsNavController()
    func presentModal(from viewController: UIViewController)
    func show(from viewController: UIViewController)
    func dismiss()
    func dismissModal()
    func dismissModal(completion: @escaping () -> Void)
    func dismissModal(animated: Bool, completion: @escaping () -> Void)
    func popToRoot()
    func showInContainer(container: UIView, in viewController: UIViewController)
}

extension Presentable where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
    
    var parent: UIViewController? {
        return viewController.parent
    }
    
    func present() {
        AppDelegate.currentWindow.rootViewController = viewController
    }
    
    func present(from viewController: UIViewController) {
        viewController.navigationController?.pushViewController(self, animated: true)
    }
    
    func presentAsNavController() {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.configureDefaultNavigationBar()
        AppDelegate.currentWindow.rootViewController = navigation
    }

    func presentModal(from viewController: UIViewController) {
        if let presentedVC = viewController.presentedViewController {
            presentedVC.dismiss(animated: false) { [weak viewController] in
                viewController?.present(self, animated: false, completion: nil)
            }
        } else {
            viewController.present(self, animated: false, completion: nil)
        }
    }
    
    func presentAsRoot() {
        AppDelegate.currentWindow.rootViewController = viewController
    }
    
    func showInContainer(container: UIView, in viewController: UIViewController) {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self.view)
        
        self.view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        self.view.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        self.view.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        let bottomConstraint = self.view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        bottomConstraint.priority = UILayoutPriority(900)
        bottomConstraint.isActive = true
        
        viewController.addChild(self)
        self.didMove(toParent: viewController)
    }
    
    func show(from viewController: UIViewController) {
        viewController.show(self, sender: viewController)
    }
    
    func dismiss() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func dismissModal(completion: @escaping () -> Void) {
        dismiss(animated: true, completion: completion)
    }
    
    func dismissModal(animated: Bool, completion: @escaping () -> Void) {
        dismiss(animated: animated, completion: completion)
    }
    
    func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func popToRoot() {
        viewController.navigationController?.popToRootViewController(animated: true)
    }
}
