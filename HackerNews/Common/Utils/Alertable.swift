//
//  Alert.swift
//  HackerNews
//
//  Created by Никита Васильев on 15/11/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit

protocol Alertable { }
extension Alertable where Self: UIViewController {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alertController.addAction(okAction)
        
        DispatchQueue.main.async {
            self.view?.window?.rootViewController?.present(alertController,
                                                           animated: true,
                                                           completion: nil)
        }
    }
}
