//
//  ModelExetendViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 8/15/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class ModelExetendViewController {
    static var shared = ModelExetendViewController()
    let fileManager = FileManager.default
    let manager = VocabularyManger.sharedInstance
    var urlPathImage: URL?
    
     private init() {}
    
    func saveImag(vocabLabel: UILabel, image: UIImage ) {
        let PathWithFolderName = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("FolderName")
        
        print("Document Directory Folder Path :- ",PathWithFolderName)
        
        if !fileManager.fileExists(atPath: PathWithFolderName)
        {
            try! fileManager.createDirectory(atPath: PathWithFolderName, withIntermediateDirectories: true, attributes: nil)
        }
        
        let url = URL(string: PathWithFolderName)
        let imagePath = url?.appendingPathComponent("\(vocabLabel.text!).png").absoluteString
        let imfData = UIImage.pngData(image)
        fileManager.createFile(atPath: imagePath!, contents: imfData(), attributes: nil)
    }
    
    func testShowImage(label: UILabel, image: UIImageView) {
        let PathWithFolderName = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("FolderName")
        
        print("Document Directory Folder Path :- ",PathWithFolderName)
        
        if !fileManager.fileExists(atPath: PathWithFolderName)
        {
            try! fileManager.createDirectory(atPath: PathWithFolderName, withIntermediateDirectories: true, attributes: nil)
        }
        
        let url = URL(string: PathWithFolderName)
        urlPathImage = url
        let imagePath = url?.appendingPathComponent("\(label.text!).png").absoluteString
        
        if fileManager.fileExists(atPath: imagePath!) {
            image.image = UIImage(contentsOfFile: imagePath!)
            
        }
        
        
    }
    
    
    
    func deletePatchImage(deleteVocab: String) {
        
        guard let imagePath = urlPathImage?.appendingPathComponent("\(deleteVocab).png").absoluteString else {
            return
        }
        guard fileManager.fileExists(atPath: imagePath) else {
            return
        }
        try? fileManager.removeItem(atPath: imagePath)
//        if fileManager.fileExists(atPath: imagePath!) {
//            try? fileManager.removeItem(atPath: imagePath!)
//        } else {
//            print("file not exist")
//        }
    
    }
    func saveData(descripTextView: UITextView) {
        if descripTextView.text.isEmpty {
            manager.realm.beginWrite()
            manager.vocabularys![manager.cellcount].descripVocab = ""
            try! manager.realm.commitWrite()
        } else {
            manager.realm.beginWrite()
            manager.vocabularys![manager.cellcount].descripVocab = descripTextView.text!
            try! manager.realm.commitWrite()
            
        }

    }
}
