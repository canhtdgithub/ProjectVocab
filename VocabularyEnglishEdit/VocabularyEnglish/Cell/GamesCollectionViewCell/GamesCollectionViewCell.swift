//
//  GamesCollectionViewCell.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/18/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "collectioncell"
    static func nib() -> UINib {
        return UINib(nibName: "GamesCollectionViewCell", bundle: .main)
    }
    
    @IBOutlet weak var showCharacter: UILabel!
    
    func config(value: Character) {
        showCharacter.text = String(value)
    }
    //    override var isHighlighted: Bool {
    //        didSet {
    //            if self.isHighlighted {
    //                backgroundColor = .black
    //            } else {
    //                backgroundColor = .gray
    //            }
    //        }
    //    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.5) {
            self.transform = .init(scaleX: 0.9, y: 0.9)
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.5) {
            self.transform = .identity
        }
    }
    
}
