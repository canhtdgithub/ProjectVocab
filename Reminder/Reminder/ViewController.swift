//
//  ViewController.swift
//  Reminder
//
//  Created by Cata on 08/26/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    var models = [MyReminder]()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reminder"
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapAddButton))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Test", style: .done, target: self, action: #selector(didTapTest))
        
//         regist
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    @objc func didTapAddButton() {
        let vc = AddViewController()
        vc.title = "New Reminder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title, body, date in
            self.navigationController?.popToRootViewController(animated: true)
            let new = MyReminder(title: title, date: date, identifier: "id_\(title)")
            self.models.append(new)
            self.table.reloadData()
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.sound = .default
            content.body = body
            
            let targerDate = date
            let trigger =  UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targerDate), repeats: false)
            
            let request = UNNotificationRequest(identifier: "hello", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if error != nil {
                    print("ko sao")
                }
            }
            
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapTest() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if success {
                self.scheduleTest()
            } else if error != nil {
                print("error")
            }
        }
    }

    func scheduleTest() {
        let content = UNMutableNotificationContent()
        content.title = "hello"
        content.sound = .default
        content.body = "jdjfdjfjsjflsjf"
        
        let targerDate = Date().addingTimeInterval(10)
        let trigger =  UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targerDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "hello", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("ko sao")
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.textLabel?.text = models[indexPath.row].title
        
        let date = models[indexPath.row].date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY"
        cell.detailTextLabel?.text = formatter.string(from: date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
}

struct MyReminder {
    let title: String
    let date: Date
    let identifier: String
}

