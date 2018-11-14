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
    func getComments(ids: [Int], _ completion: @escaping(Result<[Comment]>) -> Void)
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
    
    
    /// 
    ///
    /// - Parameters:
    ///   - ids: <#ids description#>
    ///   - completion: <#completion description#>
    public func getComments(ids: [Int], _ completion: @escaping(Result<[Comment]>) -> Void) {
        var comments: [Comment] = []
        let commentsGroup = DispatchGroup()
        
        for id in ids {
            commentsGroup.enter()
            
            NetworkManager.shared.retrieve(ids: [id]) { (response) in
                switch response {
                case .success(let items):
                    let comment = Comment(item: items.first!)
                    comment.getComments(completion: { (_) in
                        comments.append(comment)
                        commentsGroup.leave()
                    })
                case .error(let error):
                    print(error.localizedDescription)
                    commentsGroup.leave()
                    completion(Result.error(error))
                }
            }
        }
        
        commentsGroup.notify(queue: .main) {
            comments.sort { a, b in
                ids.index(of: a.id!)! < ids.index(of: b.id!)!
            }
            
            completion(Result.success(comments))
        }
    }
    
}
