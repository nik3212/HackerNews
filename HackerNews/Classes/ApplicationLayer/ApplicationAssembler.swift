//
//  ApplicationAssembler.swift
//  HackerNews
//
//  Created by Никита Васильев on 10.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Swinject

final class ApplicationAssembly {
    
    // MARK: Public Properties
    static let defaultAssembler: Assembler = {
        let assembler = Assembler()
        assembler.apply(assemblies: [
            StoriesModuleAssembly()
        ])
        return assembler
    }()
    
    static let resolver = defaultAssembler.resolver
    
    // MARK: Initialization
    private init() { }
}
