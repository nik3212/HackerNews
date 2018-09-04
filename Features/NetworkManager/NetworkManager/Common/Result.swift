//
//  Result.swift
//  NetworkManager
//
//  Created by Никита Васильев on 02/09/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case error(Error)
}
