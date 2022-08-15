//
//  StorageManager.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 02.07.2022.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let container = Storage.storage()
    private init () {}
    
    
    public func uploadUserProfile(email: String, image: UIImage?,completion:  @escaping ( Bool)-> Void) {
       
        
        let path = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        guard let pngData =  image?.pngData() else { return }
        container
            .reference(withPath: "profile_pictures/\(path)/photo.png")
            .putData(pngData, metadata: nil) { metadata, error in
                guard metadata != nil, error == nil else { completion(false)
                    return }
           completion(true)
            }
            
         
    }
    
    public func downloadUrlForProfilePicture(path: String, completion: @escaping (URL?) -> Void) {
        container.reference(withPath: path)
            .downloadURL { url, _ in
                  completion(url)
            }
    }
    
    public func uploadBlogHeaderImage (email:String, image: UIImage, postId:String,  completion: @escaping (Bool) -> Void) {
        let path = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        guard let pngData =  image.pngData() else { return }
        container
            .reference(withPath: "post_headers/\(path)/\(postId)")
            .putData(pngData, metadata: nil) { metadata, error in
                guard metadata != nil, error == nil else { completion(false)
                    return }
           completion(true)
            }
    }
   
    public func downloadUrlForPostHeader(email:String,postId: String, completion: @escaping (URL?) -> Void) {
        let emailComponent = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
    
        container
            .reference(withPath: "post_headers/\(emailComponent)/\(postId)")
            .downloadURL { url, _ in
                completion(url)
            }
            }
    }

