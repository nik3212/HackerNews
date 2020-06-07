//
//  WeakObjectSetTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

final class WeakObjectSetSpec: QuickSpec {
    override func spec() {
        let objectSet = WeakObjectSet<AnyObject>()
        
        beforeEach {
            objectSet.append(1 as AnyObject)
            objectSet.append(2 as AnyObject)
        }
        
        describe("empty set") {
            it("should contains some objects") {
                expect(objectSet.contains(1 as AnyObject)).to(equal(true))
                expect(objectSet.contains(2 as AnyObject)).to(equal(true))
                expect(objectSet.objects.count).to(equal(2))
            }
            
            it("remove objects") {
                objectSet.remove(1 as AnyObject)
                expect(objectSet.contains(1 as AnyObject)).to(equal(false))
                expect(objectSet.objects.count).to(equal(1))
            }
            
            it("appending sequence to set") {
                objectSet.append(contentsOf: [3 as AnyObject])
                expect(objectSet.contains(3 as AnyObject)).to(equal(true))
            }
        }
        
        describe("") {
            let setWithObjects = WeakObjectSet<AnyObject>(objects: [1 as AnyObject])
            
            it("should contains some objects") {
                expect(setWithObjects.contains(1 as AnyObject)).to(equal(true))
                expect(setWithObjects.objects.count).to(equal(1))
            }
        }
    }
}
