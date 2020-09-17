//
//  RegisterViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/29/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    
    
    @IBOutlet var viewRegister: UIView!
    @IBOutlet weak var firstNameField: UITextField!
    
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var imageLogo: UIImageView!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func tapRegister(_ sender: UIButton) {
        registerButtomTapped()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.firstNameField.resignFirstResponder()
        self.lastNameField.resignFirstResponder()
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        title = "Create Your Account"
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChagePicture))
        imageLogo.addGestureRecognizer(gesture)
        
        layerImage()
    }
    
    
    @objc func didTapChagePicture() {
        print("tap change picture")
        alertInsertImages()
    }
    
    func registerButtomTapped() {
        guard let firstName = firstNameField.text,
            let lastName = lastNameField.text,
            let email = emailField.text,
            let password = passwordField.text,
            !firstName.isEmpty,
            !lastName.isEmpty,
            !email.isEmpty,
            !password.isEmpty,
            password.count >= 6  else {
            self.alertUserLoginError()
            return
        }
        
        // Fire base log in
        DatabaseManager.shared.userExits(email: email) { [weak self] (exists) in
            guard let strongSelf = self else {
                              
            return
            }
            guard !exists else {
                print("Email Address exists")
                strongSelf.alertUserLoginError(message: "Email Address exists")
                return
            }
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) {  (AuthDataResult, Error) in
                
               
                guard  AuthDataResult != nil, Error == nil else {
                    
                    return
                }
                let vocaUser = VocabularyAppUser(firstName: firstName,
                lastName: lastName,
                EmailAddress: email)
                DatabaseManager.shared.insertUser(user: vocaUser ,completion: {
                                                                        success in
                                                                            if success {
                                                                                guard let image = strongSelf.imageLogo.image, let data = image.pngData() else {
                                                                                    return
                                                                                }
                                                                                let filename = vocaUser.profilePictureFileName
                                                                                StorageManager.shared.uploadProfilePicture(data: data, fileName: filename, completion: { result in
                                                                                    switch result {
                                                                                    case .success(let downloadUrl):
                                                                                        UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                                                                        print(downloadUrl)
                                                                                    case .failure(let error):
                                                                                        print("Strorage manager error: \(error)")
                                                                                    }
                                                                                })
                                                                            }
                                                                            
                })
                
                strongSelf.dismissMe(animated: true)
            }
        }
        
        
    }
    
   
    
    func layerImage() {
       
        imageLogo.layer.cornerRadius = imageLogo.frame.size.height / 2
        imageLogo.layer.borderWidth = 1
        imageLogo.layer.borderColor = UIColor.lightGray.cgColor
    }

    
    func alertUserLoginError(message: String = "Please enter to all information.") {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        } else if textField == lastNameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
        passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            registerButtomTapped()
            self.passwordField.endEditing(true)
        }
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func alertInsertImages() {
        let alert = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        
        let addImageCamera = UIAlertAction(title: "Add Photos From Camera", style: .default) { [weak self] _ in
            self?.presentCamere()
        }
        
        let addImagePhotoLibrary = UIAlertAction(title: "Add Photos From Library", style: .default) { [weak self] _ in
            self?.presentPhoto()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addImagePhotoLibrary)
        alert.addAction(addImageCamera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentCamere() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func presentPhoto() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        imageLogo.image = image
        self.dismiss(animated: true, completion: nil)
    }

}
