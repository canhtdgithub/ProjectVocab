//
//  AddViewController.swift
//  Reminder
//
//  Created by Cata on 08/26/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var bodyField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var completion: ((String, String, Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        
    }

    @objc func didTapSaveButton() {
        if let titleText = titleField.text, !titleText.isEmpty, let bodyText = bodyField.text, !bodyText.isEmpty {
            let targetDate = datePicker.date
            completion?(titleText, bodyText, targetDate)
        }
    }

}
