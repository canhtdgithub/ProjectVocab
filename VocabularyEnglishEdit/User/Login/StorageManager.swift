//
//  StorageManager.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/30/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageManager {
    static let shared = StorageManager()
    typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    let storage = Storage.storage().reference()
    
    func uploadProfilePicture(data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("image/\(fileName)").putData(data, metadata: nil,completion: { (storageMetadata, error) in
            guard error == nil else {
                print("fail to upload data to firebase for picture")
                completion(.failure(StorageError.failedToUpload))
                return
            }
            
            self.storage.child("image/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else {
                    
                    print("failed to get download url")
                    completion(.failure(StorageError.failedToGetDownloadUrl))
                    return
                }
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            })
        })
        
    }
    
    enum StorageError: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    
    }
}
