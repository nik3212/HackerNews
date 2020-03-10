//
//  StoriesConfigurator.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

final class StoriesConfigurator {
    func configure() -> StoriesViewController? {
        let viewContoller = ApplicationAssembly.resolver.resolve(StoriesViewController.self)
        return viewContoller
    }
}
