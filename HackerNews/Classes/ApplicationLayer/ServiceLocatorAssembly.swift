//
//  ServiceLocatorAssembly.swift
//  HackerNews
//
//  Created by Никита Васильев on 15.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import Swinject

final class ServiceLocatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RootConfigurator.self) { _ in
            let delegate = AppDelegate.currentDelegate
            return RootConfigurator(parentAssembler: delegate.serviceLocatorConfigurator.assembler)
        }
    }
}
