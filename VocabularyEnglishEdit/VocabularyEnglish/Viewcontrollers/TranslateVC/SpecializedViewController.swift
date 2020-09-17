//
//  SpecializedViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SpecializedViewController: UIViewController {
    
    var special = [String:String]()
    
    //MARK: - @IBOUTLET

    @IBOutlet weak var specialLabel: UILabel!
    
    //MARK: - LIFE CYCLE VIEW

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    
}
    //MARK: - EXTENSION INDICATOR INFO PROVIDER

extension SpecializedViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Specialized")
    }
}
    //MARK: - EXTENSION SPECIALIZED
extension SpecializedViewController {
    func initUI() {
        loadData()
    }
    
    func loadData() {
        specialLabel.text = special["Faculty"]
        
    }
}
