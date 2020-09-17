//
//  ModelSearchViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/7/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import SystemConfiguration

class ModelSearchViewController {
    static let shared = ModelSearchViewController()
    var url: URL?
    
    
    func search(searchTextField: UITextField, alertLabel: UILabel, selecteSegment: UISegmentedControl, dictionaryWeb: UIWebView, viewSearch: UIView) {
        if !isConnectedToNetwork() {
            searchTextField.resignFirstResponder()
            alertLabel.isHidden = false
            alertLabel.text = "Please connect to the internet."
            let _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (time) in
                alertLabel.isHidden = true
            }
            
        } else if searchTextField.text!.isEmpty {
            searchTextField.resignFirstResponder()
            alertLabel.isHidden = false
            alertLabel.text = "please enter a word you want to search."
            let _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (time) in
                alertLabel.isHidden = true
            }
        } else {
            searchTextField.resignFirstResponder()
            notifiHideKeyboard()
            
            switch selecteSegment.selectedSegmentIndex {
            case 0:
                url = URL(string: "https://dictionary.cambridge.org/dictionary/english/\(searchTextField.text!)")
                break
            case 1:
                url = URL(string: "https://www.ldoceonline.com/dictionary/\(searchTextField.text!)")
                break
                
            case 2:
                url = URL(string: "https://www.oxfordlearnersdictionaries.com/definition/english/\(searchTextField.text!)")
                
                break
            default:
                print("none")
            }
            
            dictionaryWeb.loadRequest(URLRequest(url: url ?? URL(string: "google.com")!))
            UIView.animate(withDuration: 1) {
                viewSearch.transform = CGAffineTransform(translationX: 0, y: -30)
            }
           
        }
        
        
    }
    
    
    func notifiHideKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        
    }
    
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                
            }
            
        }
        
        var flags = SCNetworkReachabilityFlags()
        
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            
            return false
            
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
        
    }
    
    
}
