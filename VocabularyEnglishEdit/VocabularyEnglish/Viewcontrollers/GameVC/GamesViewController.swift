//
//  GamesViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {
    
    let modelGamesVC = ModelQuizGames.shared
    let manager = VocabularyManger.sharedInstance
    //MARK: - @IBOUTLET
    
    @IBOutlet weak var viewAnswer: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imageQuestion: UIImageView!
    
    @IBOutlet weak var showAnswer: UILabel!
    
    @IBOutlet weak var layerSpeakerQuestion: UIButton!
    
    @IBOutlet weak var viewLayer: UIView!
    
    
    @IBOutlet weak var layerNextQuestion: UIButton!
    
    //MARK: - @IBACTION
    
    @IBAction func next(_ sender: Any) {
        modelGamesVC.testQuestions(showAnswer: showAnswer,
                                   imageQuestion: imageQuestion,
                                   collectionView: collectionView,
                                   viewPresent: self)
    }
    
    @IBAction func speakerQuestion(_ sender: UIButton) {
        sender.tapAnimation()
        SIRSpeakerManager.sharedInstance.stop()
        guard let string = modelGamesVC.stringAfterRandom else {
            return
        }
        SIRSpeakerManager.sharedInstance.speakUS(string)
        
    }
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    
}

//MARK: - EXTENSION UICOLLECTION VIEW

extension GamesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelGamesVC.tinh()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        modelGamesVC.editColor.append(true)
        modelGamesVC.tapCount.append(0)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCollectionViewCell.identifier, for: indexPath) as! GamesCollectionViewCell
        cell.config(value: modelGamesVC.stringAfterShuffled[indexPath.row])
        cell.backgroundColor = UIColor("ef5285", alpha: 1.0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! GamesCollectionViewCell
        
        modelGamesVC.changeColorCell(showAnswer: showAnswer,
                                     indexPath: indexPath,
                                     cell: cell, viewAnswer: viewAnswer)
        
    }
    
}
//MARK: - EXTENSION GAMES VIEW

extension GamesViewController {
    private func initUI() {
        modelGamesVC.settingNavigationBar(viewController: self)
        navigationItem.title = "Brain Training"
        registTable(collectionView: collectionView)
        manager.vocabularys = manager.realm.objects(Vocab.self)
    }
    
    func registTable(collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GamesCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: GamesCollectionViewCell.identifier)
        collectionView.delaysContentTouches = false
    }
}
