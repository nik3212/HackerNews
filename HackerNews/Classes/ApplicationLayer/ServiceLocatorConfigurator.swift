//
//  ServiceLocatorConfigurator.swift
//  HackerNews
//
//  Created by Никита Васильев on 15.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import Swinject

final class ServiceLocatorConfigurator {
    // MARK: Public Properties
    let assembler: Assembler
    
    // MARK: Private Properties
    private let container = Container(parent: nil)
    
    // MARK: Initialization
    init() {
        container.register(ThemeManager.self) { _ in
            return ThemeManager.shared
        }
        assembler = Assembler(container: container)
        assembler.apply(assembly: ServiceLocatorAssembly())
    }
}
