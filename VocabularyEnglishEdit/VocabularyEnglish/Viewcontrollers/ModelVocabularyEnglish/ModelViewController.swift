//
//  ModelViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/23/20.
//  Copyright © 2020 Cata. All rights reserved.
//


import RealmSwift
import InstantSearchVoiceOverlay
import AVFoundation

struct WrongVocab {
    var vocab: String
}

class VocabularyManger {
    static let sharedInstance = VocabularyManger()
    var cellcount = 0
    let realm = try! Realm()
    var vocabularys: Results<Vocab>?
    var wrongVocab = [WrongVocab]()
}

    // MARK: - VOCAB REALM

class Vocab: Object {
    @objc dynamic var vocabulary = ""
    @objc dynamic var descripVocab = ""
    
}
    // MARK: - MODEL VIEW CONTROLLER

class ModelViewController {
    static let shared = ModelViewController()
    let manager = VocabularyManger.sharedInstance
    private init() {}
    
    func insertVocab(newVocab: UITextField, tableView: UITableView) {
        if newVocab.text!.isEmpty {
        } else {
            let value = Vocab()
            value.vocabulary = newVocab.text!.lowercased()
            value.descripVocab = ""
            manager.realm.beginWrite()
            manager.realm.add(value)
            try! manager.realm.commitWrite()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
            newVocab.text = ""
        }
    }
    
    
    func changeColor(indexPath: IndexPath, vocabLabel: UILabel) {
        guard manager.wrongVocab.count > 0 else {
            vocabLabel.textColor = .black
            return
        }
        
        var isRed = false
        for i in 0...(manager.wrongVocab.count - 1) {
            if manager.vocabularys![indexPath.row].vocabulary == manager.wrongVocab[i].vocab {
                isRed = true
            }
        }
        
        if isRed {
            vocabLabel.textColor = .red
        } else {
            vocabLabel.textColor = .black
        }
    }
    
}
    // MARK: - SPEECH TO TEXT
class SpeechToText {
    static let shared = SpeechToText()
    
    func startMicrophone(viewController: UIViewController, showText: UITextField ) {
        let voice = VoiceOverlayController()
        voice.start(on: viewController,
                    textHandler: { (text, finish, nil) in
                        if finish {
                            print("fail voice")
                        } else {
                            print(text)
                            showText.text! = text
                        }
        }, errorHandler: {error in
            
        })
        
    }
}
    // MARK: - NOTIFICATION KEYBOARD
    
class NotificationKeyboard {
    
    var edgeContrains: NSLayoutConstraint!
    
    init(edgeContrains: NSLayoutConstraint) {
        self.edgeContrains = edgeContrains
    }
    
    func notifiShowKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject> {
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                self.edgeContrains.constant = keyBoardHeight
            }
        }
        
    }
    
    func notifiHideKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.edgeContrains.constant = 0
        
    }
    
}

    // MARK: - SIRI SPEAKER

class SIRSpeakerManager: NSObject {
    
    static let sharedInstance = SIRSpeakerManager()
    
    let synth = AVSpeechSynthesizer()
    
    override init() {
        super.init()
        synth.delegate = self
    }
    
    func speakUS(_ announcement: String) {
        prepareAudioSession()
        let utterance = AVSpeechUtterance(string: announcement.lowercased())
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synth.speak(utterance)
    }
    
    func speakUK(_ announcement: String) {
        prepareAudioSession()
        let utterance = AVSpeechUtterance(string: announcement.lowercased())
        utterance.voice = AVSpeechSynthesisVoice(language: "en-UK")
        synth.speak(utterance)
    }
    
    
    private func prepareAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, options: .mixWithOthers)
        } catch {
            print(error)
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
    }
    
    func stop() {
        if synth.isSpeaking {
            synth.stopSpeaking(at: .immediate)
        }
    }
}

    // MARK: - EXTENSION SIRI SPEAKER

extension SIRSpeakerManager: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("Speaker class started")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("Speaker class finished")
    }
}





