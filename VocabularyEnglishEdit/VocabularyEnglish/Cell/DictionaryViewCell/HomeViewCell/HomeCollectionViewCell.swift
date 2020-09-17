//
//  HomeCollectionViewCell.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/10/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    static let identifier = "homecollection"
    
    static func nib() -> UINib {
        return UINib(nibName: "HomeCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
