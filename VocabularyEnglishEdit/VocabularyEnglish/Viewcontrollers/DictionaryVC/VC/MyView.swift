//
//  MyView.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/5/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit



class MyView: UIView {
    
    @IBOutlet weak var imageVocab: UIImageView!
    
    @IBOutlet weak var starLayer: UIButton!
    
    @IBOutlet weak var unStarLayer: UIButton!
    
    @IBOutlet weak var vocabulary: UILabel!
    
    @IBOutlet weak var typeVocab: UILabel!
    
    @IBOutlet weak var example: UILabel!
    
    @IBAction func starButton(_ sender: UIButton) {
        if starLayer.isHidden {
            starLayer.isHidden = false
            unStarLayer.isHidden = true
            test(show: true)
        } else {
            starLayer.isHidden = true
            unStarLayer.isHidden = false
            test(show: false)
        }
        
        
    }
    
    func test(show: Bool) {
        let a = ToeicViewController()
        let b = a.vocab
        for i in 0...b.count - 1 {
            if vocabulary.text == b[i].vocabulary {
                guard var starShow = UserDefaults.standard.value(forKey: "star_toeic") as? Array<Bool> else {
                    return
                }
                starShow[i] = show
                UserDefaults.standard.set(starShow, forKey: "star_toeic")
            }
        }
    }
    
    func testShowStar(index: Int) {
        guard let star = UserDefaults.standard.value(forKey: "star_toeic") as? Array<Bool> else {
            return
        }
        if star[index] {
            starLayer.isHidden = false
            unStarLayer.isHidden = true
        } else {
            
        }
        
    }
    
    
    @IBAction func speakUS(_ sender: UIButton) {
        
        SIRSpeakerManager.sharedInstance.stop()
        SIRSpeakerManager.sharedInstance.speakUS(vocabulary.text!)
    }
    
    @IBAction func speakUK(_ sender: UIButton) {
        
        SIRSpeakerManager.sharedInstance.stop()
        SIRSpeakerManager.sharedInstance.speakUK(vocabulary.text!)
    }
    @IBAction func checkMarkButton(_ sender: Any) {
        
        
    }
    
    
    func config(value: Word700) {
        
        let name = value.vocabulary.replacingOccurrences(of: " ", with: "_")
        let path = Bundle.main.path(forResource: name, ofType: "jpg")
        let get = try! Data(contentsOf: URL(fileURLWithPath: path!))
        imageVocab.image = UIImage(data: get)
        vocabulary.text = value.vocabulary
        typeVocab.text = value.type
        example.text = value.example
        
    }
    
}
