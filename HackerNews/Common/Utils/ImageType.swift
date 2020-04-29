//
//  ImageType.swift
//  HackerNews
//
//  Created by Никита Васильев on 16.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

protocol ImageType {
    var resource: UIImage? { get }
    var resourceWhileSelected: UIImage? { get }
}

enum Image: ImageType {
    case settings
    case filter
    case connectionError
    
    var resource: UIImage? {
        switch self {
        case .settings:
            return R.image.settings()
        case .filter:
            return R.image.filterIcon()
        case .connectionError:
            return R.image.connectionErrorIcon()
        }
    }
    
    var resourceWhileSelected: UIImage? {
        return nil
    }
}
