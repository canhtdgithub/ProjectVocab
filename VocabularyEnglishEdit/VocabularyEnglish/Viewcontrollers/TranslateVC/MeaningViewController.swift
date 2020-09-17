//
//  MeaningViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MeaningViewController: UIViewController {
    
    var meaning = [String:String]()
    //MARK: - @IBOUTLET
    
    @IBOutlet weak var vocabularyLabel: UILabel!
    
    @IBOutlet weak var ipaLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var mainMeaningLabel: UILabel!
    
    //MARK: - LIFE CYCLE VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    
}
    //MARK: - EXTENSION INDICATOR INFO PROVIDER

extension MeaningViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Translate")
    }
}
    //MARK: - EXTENSION MEANING VIEW CONTROLLER

extension MeaningViewController {
    func initUI() {
        loadData()
    }
    
    func loadData() {
        vocabularyLabel.text = meaning["vocabulary"]
        ipaLabel.text = meaning["IPA"]
        typeLabel.text = meaning["type"]
        mainMeaningLabel.text = meaning["mainMeaning"]
    }
}
