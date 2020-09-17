//
//  LoginViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/29/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import Firebase


@available(iOS 11.0, *)
class LoginViewController: UIViewController {
    @IBOutlet weak var imageLogo: UIImageView!
    
    
    
    @IBOutlet weak var showLabelConnectInternet: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButtom(_ sender: Any) {
        loginButtomTapped()
        
    }
    
    @IBAction func tapRegister(_ sender: UIButton) {
        let a = RegisterViewController()
        self.navigationController?.pushViewController(a, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    func loginButtomTapped() {
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6  else {
            self.alertUserLoginError()
            return
        }
        
        // Fire base log in
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] (AuthDataResult, Error) in
            
            guard let strongSelf = self else {
                return
            }
            guard AuthDataResult != nil, Error == nil, ModelViewController.shared.isConnectedToNetwork() else {
                print("Error long in ")
                self!.showLabelConnectInternet.isHidden = false
                let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
                    self?.showLabelConnectInternet.isHidden = true
                }
                return
            }
            
            UserDefaults.standard.set(email, forKey: "email")
            
            let viewController = ViewController()
            let navi = UINavigationController(rootViewController: viewController)
                navi.tabBarItem.image = UIImage(named: "creat_vocabulary")
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            navi.navigationBar.largeTitleTextAttributes = textAttributes
                navi.navigationBar.prefersLargeTitles = true

            let gamesController = GamesViewController()
            let navi1 = UINavigationController(rootViewController: gamesController)
                navi1.tabBarItem.image = UIImage(named: "game")
            
            let searchController = SearchViewController()
            let navi3 = UINavigationController(rootViewController: searchController)
                navi3.tabBarItem.image = UIImage(named: "search")

            let settingController = SettingViewController()
            let navi2 = UINavigationController(rootViewController: settingController)
                navi2.tabBarItem.image = UIImage(named: "setting")

            UITabBar.appearance().tintColor = .red
            UITabBar.appearance().barTintColor = .black


            let tabbarViewController = UITabBarController()
            tabbarViewController.viewControllers = [navi, navi1, navi3, navi2]
            strongSelf.navigationController?.pushViewController(tabbarViewController, animated: true)
        }
    }

    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Error", message: "Please enter to all information ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

@available(iOS 11.0, *)
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            loginButtomTapped()
//            self.passwordField.endEditing(true)
        }
        return true
    }
}


