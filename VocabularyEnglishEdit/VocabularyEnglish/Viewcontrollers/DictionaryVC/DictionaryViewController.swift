//
//  DictionaryViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/3/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController {
    
    let modelDicitonVC = ModelDictionaryViewController.shared
    
    //MARK: - @IBOUTLET
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var cancelLayer: UIButton!
    
    @IBOutlet weak var speechLayer: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK: - @ACTION
    
    @IBAction func speech(_ sender: Any) {
        SpeechToText.shared.startMicrophone(viewController: self, showText: searchTextField)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        searchTextField.text = ""
        table.isHidden = true
        speechLayer.isHidden = false
        cancelLayer.isHidden = true
    }
    //MARK: - LIFE CYCLE VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.isHidden = false
    }
    
    
}
    //MARK: - EXTENSION UITABLE VIEW

extension DictionaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelDicitonVC.filterDataVocab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: DictionaryTableViewCell.identifier, for: indexPath) as! DictionaryTableViewCell
        cell.textLabel?.text = modelDicitonVC.filterDataVocab[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = table.cellForRow(at: indexPath) as! DictionaryTableViewCell
        cell.selectionStyle = .none
        modelDicitonVC.passData(cell: cell)
        let transVC = TranslateViewController()
        transVC.trans = modelDicitonVC.vocabulary
        self.navigationController?.pushViewController(transVC, animated: true)
        
    }
    
    
}
    //MARK: - EXTENSION UICOLLECTION VIEW

extension DictionaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelDicitonVC.subject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: DictionaryCollectionViewCell.identifier, for: indexPath) as! DictionaryCollectionViewCell
        cell.nameLabel.text = modelDicitonVC.subject[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(modelDicitonVC.subject[indexPath.row].view, animated: true)
    }
    
    
}
    //MARK: - EXTENSION UITEXT FIELD

extension DictionaryViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = searchTextField.text {
            
            if text.count == 1 && string == "" {
                speechLayer.isHidden = false
                cancelLayer.isHidden = true
                table.isHidden = true
            } else {
                speechLayer.isHidden = true
                cancelLayer.isHidden = false
                table.isHidden = false
                
            }
            
            modelDicitonVC.filterText(hideButton: speechLayer, showButton: cancelLayer, table: table, query: text + string)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if modelDicitonVC.filterDataVocab.isEmpty {
            modelDicitonVC.alert(viewController: self, searchTextFiled: searchTextField, table: table)
        } else {
            
            let transVC = TranslateViewController()
            transVC.trans = modelDicitonVC.vocabulary
            self.navigationController?.pushViewController(transVC, animated: true)
            textField.resignFirstResponder()
        }
        return true
        
    }
    
    
}

//MARK: - EXTENSION DICTIONARY VIEW CONTROLLER

extension DictionaryViewController {
    func initUI() {
        navigationItem.title = "Dictionary"
        regis()
        modelDicitonVC.loadDataVocab()
        modelDicitonVC.loadDiction()
        modelDicitonVC.loadSubject()
        modelDicitonVC.settingNavigationBar(viewController: self)
    }
    
    func regis() {
        // table view
        table.delegate = self
        table.dataSource = self
        searchTextField.delegate = self
        
        table.register(DictionaryTableViewCell.nib(), forCellReuseIdentifier: DictionaryTableViewCell.identifier)
        
        //collection view
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(DictionaryCollectionViewCell.nib(), forCellWithReuseIdentifier: DictionaryCollectionViewCell.identifier)
        
    }
}
