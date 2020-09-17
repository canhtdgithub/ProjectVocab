//
//  ModelQuizGames.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/24/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit


class ModelQuizGames {
    static let shared = ModelQuizGames()
    let manager = VocabularyManger.sharedInstance
    var editColor = [Bool]()
    var tapCount = [Int]()
    var stringAfterRandom: String?
    var stringAfterShuffled = [Character]()
    
    let imageWrong = ["wrong",
                      "wrong1",
                      "wrong2"]
    let imageCorrect = ["congratulation",
                        "congratulation1",
                        "congratulation2",
                        "congratulation3",
                        "congratulation4"]
    
    private init() {}
    
    func deleteText(indexPath: IndexPath, showAnswer: UILabel) {
        guard var string = showAnswer.text, string.count > 0 else {
            return
        }
        string.remove(at: string.index(string.startIndex, offsetBy: tapCount[indexPath.row] - 1, limitedBy: string.endIndex)!)
        showAnswer.text! = string
        
    }
    
    func settingNavigationBar(viewController: UIViewController) {
        let naviBar = viewController.navigationController?.navigationBar
        // bacgroudcolor navigation bar
        naviBar!.barStyle = .black
        // tip: clear color navigation bar
        naviBar!.setBackgroundImage(UIImage(), for: .default)
        naviBar!.shadowImage = UIImage()
        // set font and color title
        naviBar!.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light",
                                                                            size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func changeColorCell(showAnswer: UILabel, indexPath: IndexPath, cell: UICollectionViewCell, viewAnswer: UIView) {
        func scale() {
            UIView.animate(withDuration: 0.4, animations: {
                showAnswer.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                viewAnswer.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }) { (success) in
                UIView.animate(withDuration: 0.4, animations: {
                    showAnswer.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    viewAnswer.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }) { (success) in
                    UIView.animate(withDuration: 0.4, animations: {
                        showAnswer.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        viewAnswer.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    }) { (success) in
                        showAnswer.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                        viewAnswer.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    }
                }
                
                
            }
        }
        if editColor[indexPath.row] {
            
            tapCount[indexPath.row] = tapCount.max()! + 1
            cell.backgroundColor = .gray
            showAnswer.text?.append(stringAfterShuffled[indexPath.row])
            if showAnswer.text == stringAfterRandom {
                showAnswer.textColor = UIColor("ef5285", alpha: 1)
                SIRSpeakerManager.sharedInstance.stop()
                SIRSpeakerManager.sharedInstance.speakUS(showAnswer.text!)
                scale()
            }
            editColor[indexPath.row] = false
        } else {
            cell.backgroundColor = UIColor("ef5285", alpha: 1.0)
            deleteText(indexPath: indexPath, showAnswer: showAnswer)
            for i in 0...tapCount.count - 1 {
                if tapCount[i] > tapCount[indexPath.row] {
                    tapCount[i] -= 1
                }
            }
            if showAnswer.text != stringAfterRandom {
                showAnswer.textColor = .black
                
            }
            tapCount[indexPath.row] = 0
            editColor[indexPath.row] = true
        }
        
    }
    
    
    func tinh() -> Int {
        if manager.vocabularys!.count == 0 {
            return 0
        } else {
            self.stringAfterRandom = manager.vocabularys![Int.random(in: 0...(manager.vocabularys!.count - 1))].vocabulary
            self.stringAfterShuffled = stringAfterRandom!.shuffled()
            return stringAfterShuffled.count
        }
    }
    
    
    
    func testQuestions(showAnswer: UILabel, imageQuestion:  UIImageView, collectionView: UICollectionView, viewPresent: UIViewController ) {
        if showAnswer.text == self.stringAfterRandom {
            tinh()
            imageQuestion.image = UIImage(named: "nevergiveup")
            imageQuestion.loadGif(name: imageCorrect.randomElement()!)
            let _ = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false) { (time) in
                imageQuestion.image = UIImage(named: "nevergiveup")
                self.tapCount.removeAll()
                self.editColor.removeAll()
                showAnswer.textColor = .black
                showAnswer.text = ""
                collectionView.reloadData()
            }
            
        } else if showAnswer.text!.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "You have not entered anything, please re-enter", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            viewPresent.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "You wrong, please work again", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            manager.wrongVocab.append(WrongVocab.init(vocab: stringAfterRandom!))
            alert.addAction(cancel)
            imageQuestion.loadGif(name: imageWrong.randomElement()!)
            viewPresent.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
}


