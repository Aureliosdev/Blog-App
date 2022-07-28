//
//  DataBaseManager.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 02.07.2022.
//

import Foundation
import FirebaseFirestore

final class DataBaseManager {
    
    static let shared = DataBaseManager()
    
    private let database = Firestore.firestore()
    
    private init() {}
    
    public func insert(blogPost: BlogPost, user: User,completion: @escaping (Bool) -> Void) {
        
    }
    public func getAllPosts(completion: @escaping ([BlogPost]) -> Void) {
         
    }
    public func getPosts(for user: User,completion: @escaping ([BlogPost]) -> Void) {
        
    }
    public func insert(user: User,completion: @escaping (Bool) -> Void) {
        
        
        let documentID = user.email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        let data = ["email": user.email,
                    "name": user.name
           
        ]
        database
        
            .collection("users")
            .document(documentID)
            .setData(data)  { error  in
                completion(error == nil)
            
            }
    }
}
