//
//  StorageManager.swift
//  PartnerUpConnect
//
//  Created by lionel coevoet on 14/11/2022.
//
import Foundation
import FirebaseStorage

final class StorageManager{
    
    private let storage = Storage.storage().reference()
    
    public typealias uploadImageCompletion = (Result<String, Error>) -> Void
    
    public func uploadImage(with data: Data, fileName: String, completion : @escaping uploadImageCompletion ){
        
        storage.child("photos/\(fileName)").putData(data, metadata: nil, completion: { metadata, error in
            guard error == nil else {
                print("Failed to upload the image ")
                completion(.failure(StorageError.failedToUpload))
                return
            }
            //get the URL from firestore
            self.storage.child("photos/\(fileName)").downloadURL(completion: { url, error in
                
                guard let url = url else{
                    print("Failed to get download URL")
                    completion(.failure(StorageError.failedToGetDownloadUrl))
                    return
                }
                let urlString = url.absoluteString
                print("download url returned :\(urlString)")
                completion(.success(urlString))
            })
        })
    }
                                                    
     public enum StorageError : Error {
            case failedToUpload
            case failedToGetDownloadUrl
        }
}
