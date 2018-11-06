//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Никита Васильев on 29/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import Foundation
import Firebase

protocol NetworkEngine {
    func getIds(type: ItemType, _ completion: @escaping (Result<[Int]>) -> Void)
    func retrieve(ids: [Int], _ completion: @escaping (Result<[Item]>) -> Void)
}

public class NetworkManager: NetworkEngine {
    
    // MARK: - Properties
    
    /// Instance of NetworkManager
    public static let shared = NetworkManager()
    
    /// Instance of Firebase
    fileprivate var firebase = Firebase(url: Constants.firebaseRef)
    
    /// Count of fetched items
    var storyLimit: UInt = 100
    
    // MARK: - Initialization
    
    private init() {  }
    
    /// Returns the id of the most recent articles.
    ///
    /// - Parameters:
    ///   - type: Type of stories
    ///   - completion: The block that should be called.
    ///                 It is passed the data as an Result<[Int]>.
    public func getIds(type: ItemType, _ completion: @escaping (Result<[Int]>) -> Void) {
        firebase?.child(byAppendingPath: type.rawValue)
            .queryLimited(toFirst: storyLimit)
            .observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot,
                let ids = snapshot.value as? [Int] else { return }
            completion(.success(ids))
        }, withCancel: { (error) in
            if let error = error {
                completion(.error(error))
            }
        })
    }
    
    /// Returns articles with given id.
    ///
    /// - Parameters:
    ///   - ids: Contains articles ids.
    ///   - completion: The block that should be called.
    ///                 It is passed the data as an Result<[Item]>
    public func retrieve(ids: [Int], _ completion: @escaping (Result<[Item]>) -> Void) {
        var stories = [Int: Item]()
        for id in ids {
            let query = firebase?.child(byAppendingPath: Constants.itemChildRef).child(byAppendingPath: String(id))
            query?.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let snapshot = snapshot,
                      let item = Item(snapshot: snapshot) else { return }
                stories[id] = item
                if stories.count == ids.count {
                    var items = [Item]()
                    
                    for id in ids {
                        items.append(stories[id]!)
                    }
                    
                    completion(.success(items))
                }
            }, withCancel: { (error) in
                if let error = error {
                    completion(.error(error))
                }
            })
        }
    }
    
    /// Returns articles with type.
    ///
    /// - Parameters:
    ///   - type: Type of stories
    ///   - completion: The block that should be called.
    ///                 It is passed the data as an Result<[Item]>
    public func retrieve(type: ItemType, _ completion: @escaping (Result<[Item]>) -> Void) {
        NetworkManager.shared.getIds(type: type) { (response) in
            switch response {
            case .success(let ids):
                NetworkManager.shared.retrieve(ids: ids, completion)
            case .error(let error):
                completion(Result.error(error))
            }
        }
    }
    
    /// Set instance of Firebase
    ///
    /// - Parameter firebase: Instance of Firebase
    public func setup(with firebase: Firebase) {
        self.firebase = firebase
    }
    
}
