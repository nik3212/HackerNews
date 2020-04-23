//
//  UIViewController+.swift
//  HackerNews
//
//  Created by Никита Васильев on 23.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import UIKit

struct AlertActionModel {
    let title: String
    let style: Style
    let action: (() -> Void)?
}

extension AlertActionModel {
    enum Style {
        case `default`
        case cancel
    }
}

extension UIViewController {
    func showActionSheet(title: String? = nil, message: String? = nil,
                         actions: [AlertActionModel], completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for action in actions {
            alert.addAction(UIAlertAction(actionModel: action))
        }

        self.present(alert, animated: true, completion: completion)
    }
}

extension UIAlertAction {
    convenience init(actionModel: AlertActionModel) {
        switch actionModel.style {
        case .cancel:
            self.init(title: actionModel.title, style: .cancel, handler: { _ in
                actionModel.action?()
            })
        case .default:
            self.init(title: actionModel.title, style: .default, handler: { _ in
                actionModel.action?()
            })
        }
    }
}
