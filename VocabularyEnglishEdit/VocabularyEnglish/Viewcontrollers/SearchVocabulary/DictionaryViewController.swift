//
//  DictionaryViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 8/4/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController {

    @IBOutlet weak var web: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        web.delegate = nil
    
        let url = URL(string: "https://www.ldoceonline.com/dictionary/hello")
        web.loadRequest(URLRequest(url: url!))
    }


}
