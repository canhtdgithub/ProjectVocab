//
//  MeaningTableViewCell.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class MeaningTableViewCell: UITableViewCell {

    static var identifier = "meancell"
    static func nib() -> UINib {
        return UINib(nibName: "MeaningTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
