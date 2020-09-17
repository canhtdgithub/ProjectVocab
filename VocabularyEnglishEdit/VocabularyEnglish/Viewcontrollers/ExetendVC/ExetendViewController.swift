//
//  ExetendViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/14/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit


class ExetendViewController: UIViewController {
    let modelExtendVC = ModelExetendViewController.shared
    let manager = VocabularyManger.sharedInstance
    
    //MARK: - @IBOUTLET
    
    @IBOutlet weak var textViewContraint: NSLayoutConstraint!
    
    @IBOutlet weak var vocabLabel: UILabel!
    
    @IBOutlet weak var showImages: UIImageView!
    
    @IBOutlet weak var descripTextView: UITextView!
    
    //MARK: - @IBACTION
    
    @IBAction func actionDismiss(_ sender: UIButton) {
        self.dismissMe(animated: true)
        modelExtendVC.saveData(descripTextView: descripTextView)
    }
    
    //MARK: - TOUCH
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.descripTextView.resignFirstResponder()
    }
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

}

//MARK: - Extension UIImagePickerControllerDelegate And UINavigationControllerDelegate

extension ExetendViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func alertInsertImages() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .alert)
        
        let addImageCamera = UIAlertAction(title: "Add Photos From Camera", style: .default) { (action) in
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
        let addImagePhotoLibrary = UIAlertAction(title: "Add Photos From Library", style: .default) { (action) in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
        let addImagePhotosAlbum = UIAlertAction(title: "Add Photos From Album", style: .default) { (action) in
            let picker = UIImagePickerController()
            picker.sourceType = .savedPhotosAlbum
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addImagePhotoLibrary)
        alert.addAction(addImagePhotosAlbum)
        alert.addAction(addImageCamera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        showImages.image = image!
        // save image in document directory
        modelExtendVC.saveImag(vocabLabel: vocabLabel, image: image!)
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension ExetendViewController {
    private func initUI() {
        // Any code you put in here will be called when the keyboard is about to display
        notifiShowKeyboard()
        // Any code you put in here will be called when the keyboard is about to hide
        notifiHideKeyboard()
        inserImage()
        vocabLabel.text = manager.vocabularys![manager.cellcount].vocabulary
        modelExtendVC.testShowImage(label: vocabLabel,
                                    image: showImages)
        descripTextView.text! = manager.vocabularys![manager.cellcount].descripVocab
    }
    
    func inserImage() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        self.showImages.addGestureRecognizer(gesture)
    }
    @objc func didTapImage() {
        alertInsertImages()
    }
    
    func notifiShowKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject> {
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                self.textViewContraint.constant = keyBoardHeight
            }
        }
        
    }
    
    func notifiHideKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.textViewContraint.constant = 5
    }
}





