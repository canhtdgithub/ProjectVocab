//
//  ModelDictionary.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/4/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

struct HomeLists {
    var name: String
    var view: UIViewController
}


struct SubjectName {
    var name: String
    var view: UIViewController
}

class ModelDictionaryViewController {
    
    static let shared = ModelDictionaryViewController()
    
    var subject = [SubjectName]()
    
    var dataVocab = [String]()
    var filterDataVocab = [String]()
    var diction = [[String:String]]()
    var vocabulary = [String:String]()
    
    private init() {}
    
    func loadDataVocab() {
        let path = Bundle.main.path(forResource: "vocab_dictionary", ofType: "txt")
        let text = try! String(contentsOf: URL(fileURLWithPath: path!))
        
        let data = text.components(separatedBy: .newlines)
        dataVocab = data
    }
    
    func loadDiction() {
        let path = Bundle.main.path(forResource: "dictionary", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!))
            diction = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [[String:String]]
            
        } catch {
            print("error")
        }
        
        
    }
    
    func loadSubject() {
        subject.append(SubjectName(name: "700 Word Toeic",
                                   view: ToeicViewController()))
        subject.append(SubjectName(name: "3000 Word Common",
                                   view: WordCommonViewController()))
    }
    
    
    func passData(cell: UITableViewCell) {
        var index = 0
        for i in 0...self.dataVocab.count - 1  {
            if cell.textLabel?.text! == self.dataVocab[i] {
                index = i
            }
        }
        
        vocabulary = diction[index]
        
    }
    
    func filterText (hideButton: UIButton, showButton: UIButton,table: UITableView, query: String?) {
        filterDataVocab.removeAll()
        
        for text in dataVocab {
            if text.starts(with: query!.lowercased()) {
                filterDataVocab.append(text)
                
            }
            
        }
        
        if filterDataVocab.isEmpty {
            table.isHidden = true
        }
        DispatchQueue.main.async {
            table.reloadData()
        }
        
        
    }
    
    func alert(viewController: UIViewController, searchTextFiled: UITextField, table: UITableView) {
        let alert = UIAlertController(title: nil, message: "Your search terms did not match any definitions.", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            DispatchQueue.main.async {
                searchTextFiled.text = ""
                //                table.isHidden = true
            }
            
        }
        alert.addAction(cancel)
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
    func settingNavigationBar(viewController: UIViewController) {
        let naviBar = viewController.navigationController?.navigationBar
        // bacgroudcolor navigation bar
        naviBar!.barTintColor = UIColor("feee7d", alpha: 1.0)
        naviBar!.shadowImage = UIImage()
        // set font title
        
        naviBar!.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor("60c5ba", alpha: 1.0)]
    }
    
}
