//
//  SearchViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 8/4/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let modelSearchVC = ModelSearchViewController.shared
    
    // MARK: - @IBOUTLET
    
    @IBOutlet weak var viewSearch: UIView!
    
    @IBOutlet weak var constraintView: NSLayoutConstraint!
    @IBOutlet weak var layerSearch: UIButton!
    
    @IBOutlet weak var dictionaryWeb: UIWebView!
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var selecteSegment: UISegmentedControl!
    
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - @ACTION
    
    @IBAction func search(_ sender: Any) {
        modelSearchVC.search(searchTextField: searchTextField,
                             alertLabel: alertLabel,
                             selecteSegment: selecteSegment,
                             dictionaryWeb: dictionaryWeb, viewSearch: viewSearch)
        
    }
    // MARK: - VIEW LIFE CYCLE
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchTextField.text = ""
        dictionaryWeb.stopLoading()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
}
    // MARK: - EXTENSION UITEXTFIELD

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTextField.endEditing(true)
        return true
    }
}
    // MARK: - EXTENSION SEARCH VIEW

extension SearchViewController {
    private func initUI() {
        self.navigationController?.isNavigationBarHidden = true
        searchTextField.delegate = self
      
    }
}
