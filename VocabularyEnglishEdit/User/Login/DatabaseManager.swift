//
//  DatabaseManager.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/30/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseManager {
    static let shared = DatabaseManager()
    let database = Database.database().reference()
    
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}

extension DatabaseManager {
    
    func userExits(email: String, completion: @escaping ((Bool) -> Void)) {
        var changeEmail = email.replacingOccurrences(of: ".", with: "_")
        changeEmail = changeEmail.replacingOccurrences(of: "@", with: "_")
        
        database.child(changeEmail).observeSingleEvent(of: .value) { (napshot) in
            guard napshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        }
        
    }
    
    func insertUser(user: VocabularyAppUser, completion: @escaping (Bool) -> Void) {
        database.child(user.changeEmail).setValue([
            "First_Name": user.firstName,
            "Last_Name": user.lastName
            
            ], withCompletionBlock: { error,_ in
                guard error == nil else {
                    print("failed to write to database")
                    completion(false)
                    return
                }
                completion(true)
        })
    }
    
    enum DatabaseError: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    
    }
    
 public func insertListVocab(for email: String, completion: @escaping (Result<[ListVocab], Error>) -> Void) {
        var changeEmail = email.replacingOccurrences(of: ".", with: "_")
        changeEmail = changeEmail.replacingOccurrences(of: "@", with: "_")
    
        database.child("\(changeEmail)/vocabulary").observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else{
                completion(.failure(DatabaseError.failedToUpload))
                return
            }
            
            let listVocabs: [ListVocab] = value.compactMap({ dictionary in
                guard let vocab = dictionary["vocab"] as? String,
                    let define = dictionary["define"] as? String else {
                    return nil
                }

                return ListVocab(vocab: vocab,
                                 define: define)
            })

            completion(.success(listVocabs))
        })
    }
    

    func addVocab(email: String, text: String!) {
        if text.isEmpty {
            
        } else {
        var changeEmail = email.replacingOccurrences(of: ".", with: "_")
        changeEmail = changeEmail.replacingOccurrences(of: "@", with: "_")
        let ref = Database.database().reference().child("\(changeEmail)/vocabulary")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
           var databaseEntryConversations = [[String: Any]]()
            if var currentUserConversations = snapshot.value as? [[String: Any]] {
//                let position = currentUserConversations.count

                let newConversationData: [String: Any] = [
                    "vocab": text! as String,
                    "define": ""
                ]
                
                
//                currentUserConversations[position] = newConversationData

                    currentUserConversations.append(newConversationData)
                    databaseEntryConversations = currentUserConversations
                
            } else {
                    let newConversationData: [String: Any] = [
                        "vocab": text! as String,
                        "define": ""
                    ]
                    databaseEntryConversations.append(newConversationData)
            }
            ref.setValue(databaseEntryConversations)
        })
        }
    }
    func insertDefine(text: String, index: Int, compiletion: @escaping (Bool) -> Void) {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        var changeEmail = email.replacingOccurrences(of: ".", with: "_")
        changeEmail = changeEmail.replacingOccurrences(of: "@", with: "_")
        let ref = database.child("\(changeEmail)/vocabulary")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            var textDefine = snapshot.value as? [[String: Any]]
            textDefine![index]["define"] = text
            ref.setValue(textDefine) { (error, _) in
                guard error == nil else {
                    print("error when insert define")
                    compiletion(false)
                    return
                }
                    print("success insert")
                    compiletion(true)
                    
                
            }
        }
    }
    
    func deleteVocabulary(indexvocab: Int, compiletion: @escaping (Bool) -> Void) {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        var changeEmail = email.replacingOccurrences(of: ".", with: "_")
        changeEmail = changeEmail.replacingOccurrences(of: "@", with: "_")
        let ref = database.child("\(changeEmail)/vocabulary")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            var indexvocabs = snapshot.value as? [[String: Any]]
            indexvocabs?.remove(at: indexvocab)
            
            ref.setValue(indexvocabs) { (error, _) in
                guard error == nil else {
                    print("fail when set value")
                    compiletion(false)
                    return
                }
                print("delete success")
                compiletion(true)
            }
        }
        
    }

}

struct VocabularyAppUser {
    let firstName: String
    let lastName: String
    let EmailAddress: String
    var changeEmail: String {
        var changeEmail = EmailAddress.replacingOccurrences(of: ".", with: "_")
        changeEmail = changeEmail.replacingOccurrences(of: "@", with: "_")
        return changeEmail
    }
    var profilePictureFileName: String {
        
        return "\(changeEmail)_profile_picture.png"
    }
}
