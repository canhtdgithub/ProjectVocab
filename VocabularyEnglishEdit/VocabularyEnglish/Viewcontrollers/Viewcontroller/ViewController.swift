//
//  ViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    let modelVC = ModelViewController.shared
    let manager = VocabularyManger.sharedInstance
    
    //MARK: - @IBOUTLET
    @IBOutlet weak var viewLayer: UIView!
    @IBOutlet weak var textVocab: UITextField!
    //auto layout when keyboard hide and show
    @IBOutlet weak var tableContraint: NSLayoutConstraint!
    @IBOutlet weak var layerButtom: UIButton!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var vMain: UIView!
    
    //MARK: - @IBACTION
    @IBAction func insert(_ sender: Any) {
        modelVC.insertVocab(newVocab: textVocab, tableView: table)
    }
    
    @IBAction func microphone(_ sender: Any) {
        SpeechToText.shared.startMicrophone(viewController: self, showText: textVocab)
    }
    
    //MARK: - VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard manager.wrongVocab.count > 0 else {
            return
        }
        
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    
    override func viewDidLayoutSubviews() {
        self.vMain.gradient(firstColor: UIColor.white,
                            secondColor: UIColor(red: 0.898,
                                                 green: 0.908,
                                                 blue: 0.932,
                                                 alpha: 1))
        vMain.roundCorners(corners: [.topLeft,.topRight],
                           radius: 20)
    }

}


//MARK: - EXTENSION UITABLEVIEW

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.vocabularys?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: VocabularyTableViewCell.identifier, for: indexPath) as! VocabularyTableViewCell
        modelVC.changeColor(indexPath: indexPath, vocabLabel: cell.showVocabulary)
        cell.config(text: manager.vocabularys![indexPath.row].vocabulary)
        cell.showSpeaker()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let extend = ExetendViewController()
        manager.cellcount = indexPath.row
        extend.modalPresentationStyle = .fullScreen
        self.present(extend, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print(indexPath.row)
            ModelExetendViewController.shared.deletePatchImage(deleteVocab: manager.vocabularys![indexPath.row].vocabulary)
            manager.realm.beginWrite()
            manager.realm.delete(manager.vocabularys![indexPath.row])
            try! manager.realm.commitWrite()
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
}

//MARK: - EXTENSION UITEXTFIELDDELEGATE

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textVocab.endEditing(true)
        return true
    }
}

extension ViewController {
    private func initUI() {
        textVocab.delegate = self
        registTable(tableView: table)
        notifiShowKeyboard()
        notifiHideKeyboard()
        layerButtom.setColorIcon(btn: layerButtom,
                                 nameImage: "plus",
                                 colorIcon: UIColor("ef5285", alpha: 1))
        manager.vocabularys = manager.realm.objects(Vocab.self)
    }
    
    func registTable(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VocabularyTableViewCell.nib(), forCellReuseIdentifier: VocabularyTableViewCell.identifier)
    }
    
    func notifiShowKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject> {
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                self.tableContraint.constant = keyBoardHeight
            }
        }
        
    }
    
    func notifiHideKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.tableContraint.constant = 0
    }
}





