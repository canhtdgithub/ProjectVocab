//
//  SettingViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/14/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import MessageUI
import UserNotifications

class SettingViewController: UIViewController {
    
    let modelSettingVC = ModelSetting.shared
    
    // MARK: - @IBOUTLET
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var viewPicker: UIView!
    
    @IBOutlet weak var contrainstTable: NSLayoutConstraint!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var tick: UIButton!
    
    @IBOutlet var btn: [UIButton]!
    
    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet weak var tapSettingSwitch: UISwitch!
    
    // MARK: - @IBACTION
    
    @IBAction func reminder(_ sender: UIButton) {
        modelSettingVC.testReminder(tick: tick, contrainstTable: contrainstTable)
    }
    
    @IBAction func startTime(_ sender: Any) {
        
        viewPicker.isHidden = false
        datePicker.backgroundColor = UIColor("a5dff9", alpha: 1.0)
        
    }
    
    @IBAction func weekDay(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            modelSettingVC.changeColorButton(sender: sender, indexButton: 1)
        case 2:
            modelSettingVC.changeColorButton(sender: sender, indexButton: 2)
        case 3:
            modelSettingVC.changeColorButton(sender: sender, indexButton: 3)
        case 4:
            modelSettingVC.changeColorButton(sender: sender, indexButton: 4)
        case 5:
            modelSettingVC.changeColorButton(sender: sender, indexButton: 5)
        case 6:
            modelSettingVC.changeColorButton(sender: sender, indexButton: 6)
        case 0:
            modelSettingVC.changeColorButton(sender: sender, indexButton: 0)
        default:
            print("finish")
        }
        
    }
    
    @IBAction func tapSetting(_ sender: UISwitch) {
        if sender.isOn == false {
            UserDefaults.standard.set(false, forKey: "showvocab")
        } else {
            UserDefaults.standard.set(true, forKey: "showvocab")
            modelSettingVC.notifiDetail()
        }
        
    }
    
    // MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    
}
// MARK: - EXTENSION UITABLE VIEW

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelSettingVC.list.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! SettingTableViewCell
        
        cell.config(list: modelSettingVC.list[indexPath.row])
        
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            feedBack()
        } else {
            
        }
        
    }
    
    
}

// MARK: - EXTENSION MFMAILCOMPOSE VIEW

extension SettingViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - EXTENSION SETTING VIEW CONTROLLER

extension SettingViewController {
    private func initUI() {
        navigationItem.title = "Setting"
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge, .sound], completionHandler: {(didAllow, error) in })
        modelSettingVC.testShowVocab(tapSettingSwitch: tapSettingSwitch)
        modelSettingVC.testShowReminder(tick: tick,
                                        contrainstTable: contrainstTable)
        modelSettingVC.setColorButton(btn: btn)
        modelSettingVC.testShowTime(startLabel: startLabel)
        modelSettingVC.addItem()
        modelSettingVC.settingNavigationBar(viewController: self )
        regisTable()
        tapViewPicker()
        
        datePicker.addTarget(self, action: #selector(handl(sender:)), for: .valueChanged)
       
    }
    
    func regisTable() {
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "SettingTableViewCell", bundle: .main), forCellReuseIdentifier: "cell1")
    }
    
    func feedBack() {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["canhgithub@gmail.com"])
        composer.setSubject("Feedback")
        composer.setMessageBody("Hi you", isHTML: false)
        self.present(composer, animated: true, completion: nil)
    }
    
    
    func tapViewPicker() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(action))
        
        viewPicker.addGestureRecognizer(tap)
    }
    
    @objc func action() {
        viewPicker.isHidden = true
    }
    
    @objc func handl(sender: UIDatePicker) {
        modelSettingVC.setTimePicker(sender: sender, startLabel: startLabel)
        
    }
}
